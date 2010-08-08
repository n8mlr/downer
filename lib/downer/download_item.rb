module Downer
  
  class FailedDownload < StandardError
    attr_accessor :http_code, :url
  end
  
  class DownloadItem
    attr_reader :url
    attr_reader :content
    
    def initialize(url, destination)
      @url, @destination = sanitize_url(url), destination
      @uri = URI.parse(url)
    end
    
    # Returns the name which this file will be saved as
    def get_save_filename
      file_name = @uri.to_s
      file_name = file_name.gsub(/https?:\/\//,'').split('/').last
      file_name = file_name.gsub('%5B', '[')
      file_name = file_name.gsub('%5D', ']')
      file_name
      # TODO : refine to auto append file extentions based on content type
    end
    
    def download
      @http = Net::HTTP.new(@uri.host, @uri.port)
      if @uri.respond_to? :request_uri
        req = Net::HTTP::Get.new(@uri.request_uri)
        response = @http.request(req)

        if response.code != '200'
          fd = FailedDownload.new
          fd.http_code = response.code
          fd.url = @url
          raise fd
        else
          @content = response.body
          write_to_file
        end
      else
        puts "WARNING: Ignored download for #{@uri.inspect}"
      end

    end
    
    private
    
      def write_to_file
        file_out_path = @destination + "/#{get_save_filename}"
        fout = File.new(file_out_path, 'w')
        fout.puts @content
      end
      
      def sanitize_url(unsafe_url)
        url = unsafe_url
        url.gsub!('[', '%5B')
        url.gsub!(']', '%5D')
        url.gsub!(',', '%2C')
        url
      end
    end
end