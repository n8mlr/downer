module Downer
  class DownloadWorker
    
    attr_reader :items
    
    def initialize(urls, target_directory, output)
      @urls, @target_directory, @output = urls, target_directory, output
      @items = []
      @urls.each { |url| @items << DownloadItem.new(url, target_directory) }
    end
    
    def start
      if @urls.empty?
        @output.puts "No URLs specified, exiting." 
        return
      end
      
      @items.each { |item| try_download_item(item) }
    end
    
    private

      def try_download_item(item)
        begin
          item.download
          @output.puts "Downloaded #{item.url}"
        rescue Downer::FailedDownload => e
          @output.puts "Could not download #{e.url}, received http code #{e.http_code}"
        end
      end
  end
end