module Downer
  class Application
    
    attr_accessor :output
    attr_reader :options
    
    def initialize(output = nil)
      @output = (output) ? output : $stdout
      @options = nil
    end
    
    def run!(*arguments)
      @options = Downer::Options.new(arguments)
      download_options = {}
      

      
      # begin analysis of arguments
      if @options[:invalid_argument]
        @output.puts @options[:invalid_argument]
        @options[:show_help] = true
      end
      
      if @options[:images_only]
        print_image_only_message
        download_options[:images_only] = true
      end
      
      # Immediately exit if this will never complete
      return exit_with_help_banner if @options[:file_manifest].nil?
      return exit_with_help_banner if @options[:target_directory].nil?
      return exit_with_help_banner if @options[:show_help]
      

      begin
        manager = Downer::DownloadManager.new(@options[:file_manifest], @options[:target_directory], @output, download_options)
        manager.start
        return 0
      rescue Downer::WriteFailed
        @output.puts %Q{Insufficient permissions to write to directory}
        return 1
      end
    end
    
    private

    def print_image_only_message
      @output.puts "Images only filter selected...downloading PNG,JPG,GIF, and TIFF files"
    end
    
    def exit_with_help_banner
      @output.puts @options.opts.banner
      return 1
    end
    
  end
end