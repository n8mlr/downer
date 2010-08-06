require File.expand_path(File.dirname(__FILE__) + '../../../spec_helper')

module Downer
  module DownloadStrategy
    describe FlatFileStrategy do
      
      describe "#get_urls" do
        before(:each) do
          @flat_file_strategy = FlatFileStrategy.new(fixture_directory + '/some_images.txt')
        end
        
        it "should retrieve all urls from a text file" do
          @flat_file_strategy.get_urls.size.should == 4
        end
        
        it "should raise an error if the file does not exist" do
          lambda {
            flat_file_strat = FlatFileStrategy.new('badfile')
          }.should raise_error(Downer::URLSourceDoesNotExist)
        end
      end
    end
  end
end