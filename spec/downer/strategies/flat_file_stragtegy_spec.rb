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
        
      end
      
      describe "#source_valid?" do
        it "should return false when the local file does not exist" do
          flat_file_strategy = FlatFileStrategy.new('foobar')
          flat_file_strategy.source_valid?.should == false
        end
      end
    end
  end
end