require 'net/http'
require 'uri'

class Downer
  class Generator
    class DownloadItem
            
      attr_accessor :completed, :started, :uri, :filename, :content
      
      def initialize(url)
        @started = false
        @completed = false
        @content = nil
        @uri = URI.parse(sanitize_url!(url))
        @http = Net::HTTP.new(@uri.host, @uri.port)
      end
      
      # Returns the name which this file will be saved as
      def get_save_filename(content_type)
        file_name = @uri.to_s
        file_name = file_name.gsub!(/https?:\/\//,'').split('/').last
        file_name = file_name.gsub!('%5B', '[')
        file_name = file_name.gsub!('%5D', ']')
        file_name
        # TODO : refine to auto append file extentions based on content type
      end
      
      def download
        req = Net::HTTP::Get.new(@uri.request_uri)
        response = @http.request(req)
        @started = true
        
        if response.code == '200'
          @filename = get_save_filename(response.content_type)        
          @content = response.body
          @completed = true
          return true
        else
          return false
        end
      end
      
      private
      
      def sanitize_url!(url)
        url.gsub!('[', '%5B')
        url.gsub!(']', '%5D')
      end
    end
  end
end