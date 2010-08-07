require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')


module Downer
  describe Downer do
    describe "#run!" do
      before(:each) do
        @output = double('output').as_null_object
        @app = Application.new(@output)
      end
      
      it "when run without arguments displays a usage hint" do
        @output.should_receive(:puts).with('Usage: downer -flags URL_SOURCE DESTINATION_DIR')
        @app.run!
      end
            
      # it "when run with a -w DATA_SOURCE argument it should start a web download" do
      #   host = "http://www.urbaninfluence.com"
      #   @output.should_receive(:puts).with("Requesting from host #{host}")
      #   arg_cmd = %w{-wi http://www.urbaninfluence.com /tmp}
      #   @app.run!(arg_cmd)
      # end
    end
  end
end