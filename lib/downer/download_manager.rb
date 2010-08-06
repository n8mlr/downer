module Downer
  class WriteFailed < StandardError; end
  class BadUrl < StandardError; end
  class MalformedManifest < StandardError; end
  class NoManifestFileGiven < StandardError; end
  class NoTargetDirectoryGiven < StandardError; end
  class URLSourceDoesNotExist < StandardError; end
  
  class DownloadManager
    
    attr_accessor :target_directory, :output
    attr_reader :urls
    
    def initialize(url_source, target_directory, output)
      @url_source = url_source
      @output = output
      @target_directory = sanitize_target_directory(target_directory)
      
      @urls = []
      raise URLSourceDoesNotExist unless File.exists?(@url_source) 
      get_urls      
    end
    
    def start
      raise WriteFailed unless File.writable?(@target_directory)

      @output.puts "Starting download on #{@urls.size} files"
      worker = DownloadWorker.new(@urls, @target_directory, @output)
      worker.start
    end
    
    protected
    
      def get_urls
        f = File.open(@url_source, 'r')
        f.each_line { |line| @urls << line.chomp }
      end
      
      
      def sanitize_target_directory(dir_name)
        dir_last_char_is_slash = (dir_name[-1,1] == '/')
        dir_name = dir_name + '/' unless dir_last_char_is_slash
        dir_name
      end
    
  end
end