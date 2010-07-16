$LOAD_PATH.unshift(File.dirname(__FILE__))
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
require 'downer'
require 'spec'
require 'spec/autorun'

Spec::Runner.configure do |config|
  
end


def fixture_directory
  File.expand_path('../fixtures', __FILE__)
end

def tmp_directory
  File.expand_path('../../tmp', __FILE__)
end