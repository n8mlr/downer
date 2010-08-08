module Downer
  class WriteFailed < StandardError; end
  class BadUrl < StandardError; end
  class MalformedManifest < StandardError; end
  class NoManifestFileGiven < StandardError; end
  class NoTargetDirectoryGiven < StandardError; end
  class URLSourceDoesNotExist < StandardError; end

  
  class DownloadManager
    
    attr_accessor :target_directory, :output, :source_type
    attr_reader :urls, :downloaded_files, :strategy
    
    def initialize(url_source, target_directory, output, options ={})
      @url_source = url_source
      @output = output
      @target_directory = append_slash_to_path(target_directory) 
      @strategy = StrategyFinder::find_strategy(@url_source, options)
    end
    
    def start
      check_directory
      
      if @strategy && @strategy.source_valid?
        urls = @strategy.get_urls
        @output.puts "Starting download on #{urls.size} files"
        worker = DownloadWorker.new(urls, @target_directory, @output)
        @downloaded_files = worker.start
        print_session_summary(worker)
      else
        @output.puts "Could not open url source #{@url_source}"
      end
    end
    
    # Tells us what worked and what failed
    def print_session_summary(worker)
      @output.puts "Session complete."
      @output.puts "\n\n"
      @output.puts "----------------------------------"
      @output.puts "SUMMARY:"
      @output.puts "Successful downloads: (#{worker.successful_downloads.size})"
      @output.puts "Failed downloads: (#{worker.failed_downloads.size}): "
      worker.failed_downloads.each do |fail|
        @output.puts "  * #{fail}"
      end
    end
    
    def source_type
      @strategy.source_type
    end
    
    # Determine whether the direcotry specified exists. If it does not, see if its parent is writable. If not, give up
    # and throw error
    def check_directory
      if File.writable?(@target_directory)
        return true
      else
        #FileUtils.mkdir(@target_directory)
        raise WriteFailed
      end
    end
    
    protected
      
      # Put a slash on the directory name if one was ommited
      def append_slash_to_path(dir_name)
        dir_last_char_is_slash = (dir_name[-1,1] == '/')
        dir_name = dir_name + '/' unless dir_last_char_is_slash
        dir_name
      end
    
  end
end