module Downer
  module DownloadStrategy
    
    class FlatFileStrategy < GenericStrategy
            
      def get_urls
        urls = []
        f = File.open(@url_source, 'r')
        f.each_line { |line| urls << line.chomp}
        urls
      end
      
      def source_valid?
        File.exist?(@url_source)
      end
      
    end
  end
end