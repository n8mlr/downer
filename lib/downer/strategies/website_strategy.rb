module Downer
  module DownloadStrategy
    
    class WebsiteStrategy < GenericStrategy      
      
      # Create the downloading strategy, set any behavior flags in the options hash
      def initialize(url_source, search_options = {})
        super(url_source, search_options)
      end
      
      # Retrieve urls from an HTML page. Behavior is dependent upon options passed
      # to constructor
      def get_urls
        @noko = Nokogiri::HTML(download_page)
        urls = []
        
        if @search_options[:only_images]
          urls = image_urls
        else
          urls = urls.concat document_links
          urls = urls.concat image_urls
        end
        urls
      end
      
      # read an html page into memory
      def download_page
        @downloaded_page ||= open(@url_source)
      end
      
      def image_urls
        urls = []      
        @noko.css('img').each { |img| urls << img['src'] }
        urls
      end
      
      def document_links
        urls = []
        @noko.css('a').each do |alink|
          urls << alink['href']
        end
        urls
      end
      
      def source_valid?
        URI::parse(@url_source)
      end
      
    end
  end
end