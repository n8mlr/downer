require File.expand_path(File.dirname(__FILE__) + '../../spec_helper')

module Downer
  describe DownloadManager do
    let(:output) { double('output').as_null_object }
    let(:fixture_file_path) { fixture_directory + '/some_images.txt' }
    let(:manager) { DownloadManager.new(fixture_file_path, 'myoutputdir', output) }
    
    describe "#new" do  
      it "should add a slash as the last character of the target directory if one is not present" do
        manager.target_directory.should == 'myoutputdir/'
      end
            
      it "should retrieve all urls from the url source" do
        manager.urls.should_not be_empty
      end
    end
    
    describe "#start" do
      
      it "should raise an error when the file does not exist" do
        File.should_receive(:exists?).with(fixture_file_path)
        lambda { manager.start }.should raise_error(Downer::URLSourceDoesNotExist)
      end
      it "should raise a WriteFailed exception if the target directory is not writable" do
        File.should_receive(:writable?).with('myoutputdir/').and_return(false)
        lambda { manager.start }.should raise_error(Downer::WriteFailed)
      end

      
      it "should create a download worker to begin the downloading" do
        File.should_receive(:writable?).and_return(true)
        worker = double('worker')
        worker.should_receive(:start)
        DownloadWorker.should_receive(:new).and_return(worker)
        manager.start
      end
    end
      
  end
end