require 'spec_helper'

describe 'Wedding' do
  before(:each) do
    WeddingRequest.base_uri "http://wedding-api.herokuapp.com" 
  end

  context "A user visits the home page" do 
    
    before(:each) do
      visit root_path
    end

    it "sees a list of weddings" do
      page.should have_content "Lots of beer!"
    end


    context "Cannot retrieve weddings" do
      before(:each) do
        WeddingRequest.base_uri "http://wrong.wedding-api.herokuapp.com" 
      end

      pending it "sees an error" do
       page.should have_content "Unable to retrieve weddings."
      end
    end
  end
end