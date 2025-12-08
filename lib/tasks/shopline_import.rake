# lib/tasks/shopline_import.rake
namespace :shopline do
    desc '匯入 Shopline 客戶資料從 Excel 檔案'
    task :import_customers, [:file_path] => :environment do |task, args|
      file_path = args[:file_path]
      
      if file_path.blank?
        puts "請指定檔案路徑。例如: rake shopline:import_customers['/path/to/file.xls']"
        next
      end
      
      unless File.exist?(file_path)
        puts "錯誤: 找不到檔案 #{file_path}"
        next
      end
      
      puts "開始匯入客戶資料..."
      start_time = Time.now
      
      importer = ShoplineCustomerImporter.new(file_path)
      result = importer.import
      
      end_time = Time.now
      duration = (end_time - start_time).round(2)
      
      puts "匯入完成! 用時: #{duration} 秒"
      puts "成功匯入 #{result[:imported]} 筆客戶資料"
      
      if result[:errors].any?
        puts "發生 #{result[:errors].size} 筆錯誤:"
        result[:errors].each do |error|
          puts "  顧客 ID: #{error[:id]} - #{error[:errors].join(', ')}"
        end
      end
    end
  end