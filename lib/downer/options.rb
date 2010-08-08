module Downer
  class Options < Hash
    attr_reader :opts, :orig_args
    
    def initialize(args)
      @opts = args.clone
      self[:is_website] = false
      self[:images_only] = false

      @opts = OptionParser.new do |o|
        o.banner = "Usage: downer -flags URL_SOURCE DESTINATION_DIR"
        
        o.on('-i', '--image', 'When combined with w will download JPG,GIF,PNG formats') do
          self[:images_only] = true
        end
      end
      
      begin
        @opts.parse!(args)
        self[:file_manifest] = args.shift
        self[:target_directory] = args.shift
      rescue OptionParser::InvalidOption => e
        self[:invalid_argument] = e.message
      end
    end
  end
end