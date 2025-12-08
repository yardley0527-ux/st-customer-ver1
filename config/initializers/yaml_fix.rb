# Fix for YAML aliases with Psych in Ruby 3.2.0+
require 'yaml'
module YAMLPatchForWebpacker
  def load(yaml, *args)
    # Always enable aliases when used by Webpacker
    if caller.any? { |c| c.include?('/webpacker/') }
      super(yaml, aliases: true)
    else
      super
    end
  end
end

# Apply the patch
Psych.singleton_class.prepend(YAMLPatchForWebpacker)