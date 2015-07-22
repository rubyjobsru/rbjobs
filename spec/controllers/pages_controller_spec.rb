require 'rails_helper'

RSpec.describe PagesController do
  let(:page) { instance_double(Page) }

  describe "GET 'show'" do
    context "when page exists" do
      before { allow(Page).to receive(:find_by_id).and_return(page) }

      it "should be successful" do
        get 'show', :id => page
        expect(response).to be_success
      end
    end
    context "when page doesn't exist" do
      before { allow(Page).to receive(:find_by_id).and_return(nil) }

      it "should be not found" do
        get 'show', :id => page
        expect(response).to be_not_found
      end
    end
  end
end
