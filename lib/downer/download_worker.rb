module Downer
  class DownloadWorker
    
    attr_reader :items, :successful_downloads, :failed_downloads
    
    def initialize(urls, target_directory, output)
      @urls, @target_directory, @output = urls, target_directory, output
      @urls.delete_if { |url| url == nil }
      @items = []
      @successful_downloads = []
      @failed_downloads = []
      
      @urls.each { |url| @items << DownloadItem.new(url, target_directory) }
    end
    
    def start
      if @urls.empty?
        @output.puts "No URLs specified, exiting." 
        return
      end
      
      @items.each { |item| try_download_item(item) }
      successful_downloads
    end
    
    private

      def try_download_item(item)
        begin
          item.download
          @successful_downloads << item.url
          @output.puts "Downloaded #{item.url}"
        rescue Downer::FailedDownload => e
          @output.puts "Could not download #{e.url}, received http code #{e.http_code}"
          @failed_downloads << item.url
        rescue SocketError => e
          @output.puts "SocketError encountered on url #{item.url}"
          @failed_downloads << item.url
        end
      end
  end
end