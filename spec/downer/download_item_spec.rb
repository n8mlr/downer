require File.expand_path(File.dirname(__FILE__) + '../../spec_helper')

module Downer
  describe DownloadItem do    
    
    describe "#initialize" do
      it "should escape bad url tokens" do
        item = DownloadItem.new('http://www.urbaninfluence.com/my[place].html', '/tmp')
        item.url.should == 'http://www.urbaninfluence.com/my%5Bplace%5D.html'
      end
    end
    
    describe "#get_save_filename" do
      it "should generate a filename from its download url" do
        item = DownloadItem.new('http://www.urbaninfluence.com/sites/default/files/user_uploads/images/mapsAndAtlases2.png', '/tmp')
        item.get_save_filename.should == 'mapsAndAtlases2.png'
      end
      
      it "should successfully encode invalid chars into ASCII equivalents" do
        item = DownloadItem.new('http://www.urbaninfluence.com/My File_Name With White space.png', '/tmp')
        item.url.should == 'http://www.urbaninfluence.com/My%20File_Name%20With%20White%20space.png'
      end

      it "should restore bad url tokens into valid ascii characters" do
        item = DownloadItem.new('http://www.urbaninfluence.com/my[place].html', '/tmp')
        item.get_save_filename.should == 'my[place].html'
      end
    end
    
    describe "#download" do
      before(:each) do
        FileUtils.rm_r(Dir.glob(tmp_directory + '/*'))
      end
      
      it "should write the url to the target directory" do
        item = DownloadItem.new('http://www.urbaninfluence.com/sites/default/files/user_uploads/images/mapsAndAtlases2.png', tmp_directory)
        item.download
        Dir.entries(tmp_directory).size.should > 2
      end
      
      it "should raise an error when a url is unable to be downloaded" do
        item = DownloadItem.new('http://www.urbaninfluence.com/will_never_complete', tmp_directory)
        lambda { item.download }.should raise_error(Downer::FailedDownload)
      end
    end
  end
end