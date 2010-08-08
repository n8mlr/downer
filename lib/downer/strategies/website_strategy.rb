module Downer
  module DownloadStrategy
    
    class WebsiteStrategy < GenericStrategy      
      
      # Create the downloading strategy, set any behavior flags in the options hash
      def initialize(url_source, search_options = {})
        super(url_source, search_options)
        uri = URI.parse(url_source)
        @host_prefix = uri.scheme + "://" + uri.host
      end
      
      # Retrieve urls from an HTML page. Behavior is dependent upon options passed
      # to constructor
      def get_urls
        @noko = Nokogiri::HTML(download_page)
        urls = []
        
        if @search_options[:images_only]
          urls = image_urls
        else
          urls = urls.concat document_links
          urls = urls.concat image_urls
        end
        urls.uniq
      end
      
      # read an html page into memory
      def download_page
        @downloaded_page ||= open(@url_source)
      end
      
      # Return all image urls from document
      def image_urls
        urls = []      
        @noko.css('img').each do |img| 
          urls << absolutify_link(img['src'])
        end
        urls
      end
      
      # Return all links stored within the document
      def document_links
        urls = []
        @noko.css('a').each do |alink|
          link = alink['href']
          urls << absolutify_link(link)
        end
        urls
      end
      
      # Converts non absolute urls to absolute ones
      def absolutify_link(link)
        
        # Auto prepend any links which refer use releative reference like '../'
        if link[0,1] == '.'
          link = '/' + link
        end
        
        if link =~ /(https?|ftp).*/
          url = link
        elsif link[0,1] != '/'
          link = "/" + link
        else
          url = @host_prefix + link
        end
      end
      
      def source_valid?
        URI.parse(@url_source)
      end
      
    end
  end
end