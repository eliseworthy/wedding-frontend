require 'spec_helper'

describe 'Wedding' do
  before(:each) do
    WeddingRequest.base_uri "http://wedding-api.herokuapp.com"
  end

  context "A user visits the home page" do

    before(:each) do
      visit root_path
    end

    it "sees the welcome banner" do
      page.should have_content "Dream Wedding Planning"
    end

    it "has three weddings" do
      page.should have_selector('.bar', count: 3)
    end

    it "has button to sign up" do
      page.should have_button "Sign Up >"
    end

    it "has a honeymoon search button" do
      page.should have_button "Search for Honeymoons"
    end

    it "has button to search for ideas" do
      page.should have_button "Search for Ideas"
    end

    it "can sign up from the homepage" do
      click_button('Sign Up >')
      page.should have_content "Sign Up"
    end

    it "can search honeymoons from the homepage" do
      click_button('Search for Honeymoons')
      page.should have_content "Honeymoon Ideas"
    end

    it "can search pins from the homepage" do
      fill_in('search', :with => 'Gown')
      click_button('Search for Ideas')
      page.should have_content "Wedding Ideas"
    end
  end
end