require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')


module Downer
  describe Downer do
    describe "#run!" do
      it "when run without arguments displays a usage hint" do
        output = double('output')
        app = Application.new(output)
        output.should_receive(:puts).with('Usage: downer URL_SOURCE DESTINATION_DIR')
        app.run!
      end
      
      it "when run with valid arguments displays the number of files to download" do
        output = double('output').as_null_object
        app = Application.new(output)
        output.should_receive(:puts).with("Starting download on 4 files")
        app.run!(fixture_directory + "/some_images.txt", '/tmp')
      end
    end
  end
end