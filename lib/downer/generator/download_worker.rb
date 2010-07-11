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
          @targets << DownloadItem.new(url)
        end
      end
      
      def start
        $stdout.puts "Will begin donwloading #{@targets.size} items"
        @targets.each do |item|
          if item.download
            fout = File.new("#{@write_directory}#{item.filename}", 'w')
            fout.puts item.content
            $stdout.puts "Downloaded #{item.filename}"
          else
            $stderr.puts "Could not retrieve #{item.uri}"
          end
        end
      end
    end
  end
end