require 'spec_helper'

describe Page do
  subject{ stub_model(Page) }

  describe ".find_by_id" do
    context "when page exists" do
      before{ Page.stub(:exists? => true) }

      it "should create a new page" do
        Page.should_receive(:new).with("foo")
        Page.find_by_id("foo")
      end
      it "should return page with given id" do
        page = Page.find_by_id("foo")
        page.id.should == "foo"
      end
    end
    context "when page doesn't exists" do
      before{ Page.stub(:exists? => false) }

      it "should return nil" do
        Page.find_by_id("foo").should be_nil
      end
    end
  end

  describe ".exists?" do
    before{ Page.stub(:ids => ["foo", "bar"]) }

    context "when list of ids includes given id" do
      it "should return true" do
        Page.exists?("foo").should be_true
      end
    end
    context "when list of ids doesn't include given id" do
      it "should return false" do
        Page.exists?("foobar").should be_false
      end
    end
  end
end
