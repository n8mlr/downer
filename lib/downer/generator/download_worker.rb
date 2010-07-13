require 'net/http'
require 'uri'

class Downer
  class Generator
    class DownloadWorker
      
      attr_reader :targets
      
      def initialize(urls, write_directory)
        @targets = []
        @write_directory = write_directory
        urls.each do |url|
          item = try_create_download_item(url)
          @targets << item if item
        end
      end
      
      def start
        $stdout.puts "Will begin donwloading #{@targets.size} items"
        @targets.each do |item|
          if item.download
            fout = File.new("#{@write_directory}#{item.filename}", 'w')
            fout.puts item.content
            $stdout.puts "Downloaded:: #{item.filename}"
          else
            $stderr.puts "Could not retrieve:: #{item.uri}"
          end
        end
      end
    
      private
      
      def try_create_download_item(url)
        begin
          di = DownloadItem.new(url)
          return di
        rescue URI::InvalidURIError => e
          $stderr.puts "Skipped bad url: #{url}"
        end
      end
    end
  end
end