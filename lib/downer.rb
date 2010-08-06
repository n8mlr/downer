require 'net/http'
require 'optparse'

Dir.glob(File.dirname(__FILE__) + '/**/*.rb').each { |file| require file }