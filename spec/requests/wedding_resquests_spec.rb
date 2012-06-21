require 'spec_helper'

describe 'Wedding' do
  context "A user visits the home page" do 
    
    before(:each) do
      visit root_path
    end

    it "sees a list of weddings" do
      page.should have_content "Lots of beer!"
    end
  end
end