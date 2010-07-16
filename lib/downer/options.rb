module Downer
  class Options < Hash
    attr_reader :opts, :orig_args
    
    def initialize(args)
      
      @orig_args = args.clone
      @opts = OptionParser.new do |o|
        o.banner = "Usage: downer URL_SOURCE DESTINATION_DIR"
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