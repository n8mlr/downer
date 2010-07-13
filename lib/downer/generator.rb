class Downer
  class WriteFailed < StandardError; end
  class BadUrl < StandardError; end
  class MalformedManifest < StandardError; end
  class NoManifestFileGiven < StandardError; end
  class NoTargetDirectoryGiven < StandardError; end

  # Generator class responsible for creating worker objects
  class Generator
    require 'downer/generator/application'
    require 'downer/generator/options'
    require 'downer/generator/download_worker'
    require 'downer/generator/download_item'
    
    attr_accessor :file_manifest, :target_directory, :options
    
    def initialize(options = {})
      self.options = options
      self.file_manifest = options[:file_manifest]
      self.target_directory = options[:target_directory]
      
      if self.file_manifest.nil?
        raise NoManifestFileGiven
      end
      
      if self.target_directory.nil?
        raise NoTargetDirectoryGiven
      else
        last_char_is_slash = (self.target_directory[-1,1] == '/')
        self.target_directory = self.target_directory + '/' unless last_char_is_slash
      end
      
      unless File.writable?(self.target_directory)
        raise WriteFailed
      end
    end
    
    def run
      $stdout.puts "Starting downloader"
      urls = get_urls(self.file_manifest)
      worker = DownloadWorker.new(urls, self.target_directory)
      worker.start
    end
    
    private
    
    def get_urls(file_manifest)
      urls = []
      f = File.open(file_manifest, 'r')
      f.each_line { |line| urls << line.chomp }
      urls
    end
  end
end