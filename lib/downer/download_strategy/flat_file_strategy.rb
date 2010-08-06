module Downer
  module DownloadStrategy
    class FlatFileStrategy
      
      def initialize(flat_file)
        if File.exist?(flat_file)
          @url_source = flat_file
        else
          raise Downer::URLSourceDoesNotExist
        end
      end
      
      def get_urls
        urls = []
        f = File.open(@url_source, 'r')
        f.each_line { |line| urls << line.chomp}
        urls
      end
    end
  end
end