module Downer
  class WriteFailed < StandardError; end
  class BadUrl < StandardError; end
  class MalformedManifest < StandardError; end
  class NoManifestFileGiven < StandardError; end
  class NoTargetDirectoryGiven < StandardError; end
  class URLSourceDoesNotExist < StandardError; end
  
  class DownloadManager
    
    attr_accessor :file_manifest, :target_directory, :output
    attr_reader :urls
    
    def initialize(url_source, target_directory, output)
      @file_manifest, @target_directory, @output = url_source, target_directory, output
      dir_last_char_is_slash = (@target_directory[-1,1] == '/')
      @target_directory = @target_directory + '/' unless dir_last_char_is_slash
      @urls = []
      raise URLSourceDoesNotExist unless File.exists?(@file_manifest) 
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
        f = File.open(@file_manifest, 'r')
        f.each_line { |line| @urls << line.chomp }
      end
    
  end
end