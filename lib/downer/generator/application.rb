class Downer
  class Generator
    class Application
      class << self
        def run!(*arguments)
          options = Downer::Generator::Options.new(arguments)
          
          if options[:invalid_argument]
            $stderr.puts options[:invalid_argument]
            options[:show_help] = true
          end
          
          if options[:show_help]
            $stderr.puts options.opts
            return 1
          end
          
          if options[:target_directory].nil?
            $stderr.puts options.opts
            return 1
          end
          
          if options[:file_manifest].nil?
            $stderr.puts options.opts
            return 1
          end

          begin
            generator = Downer::Generator.new(options)
            generator.run
            return 0
          rescue Downer::MalformedManifest
            $stderr.puts %Q{Improper format of manifest file}
          rescue Downer::WriteFailed
            $stderr.puts %Q{Insufficient permissions to write to directory}
            return 1
          end
          
        end
      end
    end
  end
end
    