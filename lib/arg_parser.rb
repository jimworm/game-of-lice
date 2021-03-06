module ArgParser
  @defaults = {file: nil, speed: nil, rounds: 100, random: true, prob: 10}
  
  class << self
    def parse(args)
      args.reduce(@defaults) do |settings, arg|
        settings.merge(arg.include?('=') ? parse_arg(arg) : parse_file(arg))
      end
    end
    
    def parse_arg(arg)
      split = arg.split '='
      setting = case split.first.downcase
        when 'width', 'height', 'speed', 'prob', 'rounds' then split.last.to_i
        when 'random' then (split.last.downcase == 'true')
      end
      { :"#{split.first.downcase}" => setting }
    end
    
    def parse_file(basename)
      filename = if File.exists?(basename)
        basename
      elsif File.exists?("levels/#{basename}")
        "levels/#{basename}"
      end
      
      filename ? {file: File.readlines(filename)} : {}
    end
  end
end
