require 'spec_helper'

describe PagesController do
  let(:page) { stub_model(Page) }
  describe "GET 'show'" do
    context "when page exists" do
      before{ Page.stub(:find_by_id => page) }

      it "should be successful" do
        get 'show', :id => page
        response.should be_success
      end
    end
    context "when page doesn't exist" do
      before{ Page.stub(:find_by_id => nil) }

      it "should be not found" do
        get 'show', :id => page
        response.should be_not_found
      end
    end
  end
end
