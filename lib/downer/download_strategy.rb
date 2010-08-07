module Downer
  
  class StrategyFinder
    class << self
      
      # Determines a strategy for extracting urls from a media type
      def find_strategy(url_source, options ={})
        strategy = nil
                
        if is_local_file?(url_source)
          strategy = DownloadStrategy::FlatFileStrategy.new(url_source, options)
        elsif is_remote_source?(url_source)
          strategy = DownloadStrategy::WebsiteStrategy.new(url_source, options)
        else
          # pooo...
        end
        strategy
      end
      
      # Determine whether the source is located on a local file system
      def is_local_file?(url_source)
        File.exist?(url_source)
      end
      
      # Determine if this is something that lives online
      def is_remote_source?(url_source)
        #if url_source =~ /(ftp|https?).*$/
        url_source.match(/(ftp|https?).*$/) ? true : false
      end
      
    end
  end
  
end