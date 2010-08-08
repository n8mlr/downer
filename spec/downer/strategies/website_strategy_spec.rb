require File.expand_path(File.dirname(__FILE__) + '../../../spec_helper')

module Downer
  module DownloadStrategy
    describe WebsiteStrategy do
      
      it "should automatically prepend the host for relative urls" do
        @web_strategy = WebsiteStrategy.new('http://www.example.com')
        downloaded_page_mock = IO.read(fixture_directory + '/basic_page.html')
        @web_strategy.should_receive(:download_page).and_return(downloaded_page_mock)
        @web_strategy.get_urls.should include('http://www.example.com/clickhere.html')
      end
      
      describe "default get_urls behavior" do
        before(:each) do
          @web_strategy = WebsiteStrategy.new('http://www.example.com')
          downloaded_page_mock = IO.read(fixture_directory + '/basic_page.html')
          @web_strategy.should_receive(:download_page).and_return(downloaded_page_mock)
        end
        
        it "should retrieve 5 urls fom basic_page.html fixture" do
          @web_strategy.get_urls.size.should == 5
        end
      end
      
      describe "get images only behavior" do
        before(:each) do
          @web_strategy = WebsiteStrategy.new('http://www.example.com', {:images_only => true} )
          downloaded_page_mock = IO.read(fixture_directory + '/basic_page.html')
          @web_strategy.should_receive(:download_page).and_return(downloaded_page_mock)
        end
        
        it "should retrieve 3 urls from basic_page.html fixture with images only mode enabled" do
          @web_strategy.get_urls.size.should == 3
        end
      end
      
      describe "image searching" do
        it "should skip duplicate urls" do
          @web_strategy = WebsiteStrategy.new('http://www.example.com', :images_only => true)
          downloaded_page_mock = <<-PAGE
            <img src="/sites/image.png" />
            <img src="/sites/image.png" />
          PAGE
          @web_strategy.should_receive(:download_page).and_return(downloaded_page_mock)
          @web_strategy.get_urls.size.should == 1
        end
        
        it "should retrieve 3 images from basic_page.html fixture" do
          @web_strategy = WebsiteStrategy.new('http://www.example.com', :images_only => true)
          downloaded_page_mock = IO.read(fixture_directory + '/basic_page.html')
          @web_strategy.should_receive(:download_page).and_return(downloaded_page_mock)
          @web_strategy.get_urls.size.should == 3
        end
      end
    end
  end
end