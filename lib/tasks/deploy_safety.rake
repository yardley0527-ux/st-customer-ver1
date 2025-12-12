# lib/tasks/deploy_safety.rake
# 為何：部署前先 migrate 並檢查 schema；缺欄位直接 fail，避免上線炸 500。
require "yaml"

namespace :deploy do
  def cfg_path = Rails.root.join("config/deploy_preflight.yml")

  def load_config
    if File.exist?(cfg_path)
      raw = YAML.load_file(cfg_path) || {}
      fail_on_extra = !!raw.fetch("fail_on_extra", false)
      tables = (raw["tables"] || {}).each_with_object({}) { |(t, cols), h| h[t.to_s] = Array(cols).map(&:to_s) }
      [fail_on_extra, tables]
    else
      [false, {}]
    end
  end

  def needs_migration?(conn)
    if conn.respond_to?(:migration_context) then conn.migration_context.needs_migration?
    else ActiveRecord::Migrator.needs_migration?
    end
  end

  def table_diff(conn, table, expected_cols)
    return [:table_missing, [], []] unless conn.data_source_exists?(table)
    present = conn.columns(table).map(&:name)
    missing = expected_cols - present
    extra   = present - expected_cols
    [:ok, missing, extra]
  end

  desc "Run migrations then sanity-check schema; fail fast if something is missing"
  task preflight: :environment do
    puts "== deploy:preflight"
    Rake::Task["db:migrate"].invoke                       # 為何：先把 DB 升到最新
    fail_on_extra, required = load_config
    conn = ActiveRecord::Base.connection
    problems, warnings = [], []

    puts "== schema checks"
    required.each do |table, cols|
      status, missing, extra = table_diff(conn, table, cols)
      if status == :table_missing
        problems << "table #{table} is missing"
        next
      end
      problems.concat(missing.map { |c| "column #{table}.#{c} is missing" })
      if fail_on_extra
        problems.concat(extra.map { |c| "column #{table}.#{c} exists but not expected (extra)" })
      else
        warnings.concat(extra.map { |c| "column #{table}.#{c} is extra (warning only)" })
      end
    end

    problems << "pending migrations remain after db:migrate" if needs_migration?(conn)
    warnings.uniq.each { |w| puts "⚠︎ #{w}" } unless warnings.empty?

    if problems.empty?
      puts "✓ preflight passed"
    else
      $stderr.puts "✗ preflight failed:"
      problems.uniq.each { |m| $stderr.puts "  - #{m}" }
      exit 1                                           # 為何：阻擋壞 schema 上線
    end
  end

  desc "Print DB vs expected schema differences (report only)"
  task schema_diff: :environment do
    puts "== deploy:schema_diff"
    _, required = load_config
    conn = ActiveRecord::Base.connection
    any = false
    required.each do |table, cols|
      puts "-- #{table}"
      if conn.data_source_exists?(table)
        present = conn.columns(table).map(&:name)
        missing = cols - present
        extra   = present - cols
        if missing.empty? && extra.empty?
          puts "   ok"
        else
          any = true
          puts "   missing: #{missing.join(', ')}" unless missing.empty?
          puts "   extra:   #{extra.join(', ')}"   unless extra.empty?
        end
      else
        any = true
        puts "   table missing"
      end
    end
    puts any ? "\n✗ differences found" : "\n✓ no differences"
  end
end
