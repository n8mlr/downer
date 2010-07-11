require 'optparse'

class Downer
  class Generator
    class Options < Hash
      attr_reader :opts, :orig_args
      
      def initialize(args)
        
        @orig_args = args.clone
        @opts = OptionParser.new do |o|
          o.banner = "Usage: #{File.basename($0)} URLS.txt DESTINATION_DIR"
          
          # o.on('-u USERNAME (optional)', 'specify the username credential to be sent in request') do |user_name|
          #   self[:user_name] = user_name
          # end
          # 
          # o.on('-p PASSWORD (optional)', 'specify the password credential to be sent in request') do |password|
          #   self[:password] = password
          # end
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
end