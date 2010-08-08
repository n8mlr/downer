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
      
      it "when passed an option hash containing :images_only, only images will be downloaded for this session" do
        mgr = DownloadManager.new("http://localhost/basic_page.html", '/tmp', output, {:images_only => true})
        mgr.strategy.options[:images_only].should == true
      end
    end
    
    describe "#start" do
      
      it "should raise a WriteFailed exception if the target directory is not writable" do
        File.should_receive(:writable?).with('myoutputdir/').and_return(false)
        lambda { manager.start }.should raise_error(Downer::WriteFailed)
      end
      
      it "should create the specified directory if it does not exist and its parent directory is writable" 
      ## do
      #         if File.exist?('/tmp/new-directory')
      #           FileUtils.rm_rf('/tmp/new-directory')
      #         end
      #         create_mgr = DownloadManager.new(fixture_file_path, '/tmp/new-directory', output)
      #         create_mgr.start
      #         File.exist?('/tmp/new-directory').should == true
      #       end
      
      it "should create a download worker to begin the downloading" do
        File.should_receive(:writable?).and_return(true)
        worker = double('worker').as_null_object
        worker.should_receive(:start)
        DownloadWorker.should_receive(:new).and_return(worker)
        manager.start
      end
      
      it "should resolve to use a flat file strategy when it receives a file data source" do
        dm = DownloadManager.new(fixture_file_path, 'myoutputdir', output)
        dm.source_type.should == "flatfile"
      end
      
      it "should resolve to use a web strategy when it receives a data source that looks like a url" do
        dm = DownloadManager.new('http://www.msn.com', 'myoutputdir', output)
        dm.source_type.should == "website"
      end
      
    end
      
  end
end