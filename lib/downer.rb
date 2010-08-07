require 'rubygems'
require 'net/http'
require 'nokogiri'
require 'optparse'

Dir.glob(File.dirname(__FILE__) + '/**/*.rb').each { |file| require file }