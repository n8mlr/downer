require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

module Downer
  describe Options do
    it "when passed '-i' the option image_only will be set to true" do
      op_struct = Options.new(['-i'])
      op_struct[:images_only].should == true
    end
  end
end