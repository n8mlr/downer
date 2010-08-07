require File.expand_path(File.dirname(__FILE__) + '../../spec_helper')

module Downer
  describe StrategyFinder do
    describe "Class method find_strategy" do
      it "should return flat file strategy when url source is a local file" do
        strategy = StrategyFinder.find_strategy(fixture_directory + '/some_images.txt')
        strategy.should respond_to :get_urls
      end
      
      it "should return a website strategy when url source is a web resource"
    end
  end
end