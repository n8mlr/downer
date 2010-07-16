module Downer
  class Application
    
    attr_accessor :output
    
    def initialize(output = nil)
      @output = (output) ? output : $stdout
      @options = nil
    end
    
    def run!(*arguments)
      @options = Downer::Options.new(arguments)
      
      if @options[:invalid_argument]
        @output.puts @options[:invalid_argument]
        @options[:show_help] = true
      end
      
      return exit_with_help_banner if @options[:file_manifest].nil?
      return exit_with_help_banner if @options[:target_directory].nil?
      return exit_with_help_banner if @options[:show_help]
      
      begin
        manager = Downer::DownloadManager.new(@options[:file_manifest], @options[:target_directory], @output)
        manager.start
        return 0
      rescue Downer::MalformedManifest
        $stderr.puts %Q{Improper format of manifest file}
      rescue Downer::WriteFailed
        $stderr.puts %Q{Insufficient permissions to write to directory}
        return 1
      end
    end
    
    private
    
    def exit_with_help_banner
      @output.puts @options.opts.banner
      return 1
    end
    
  end
end