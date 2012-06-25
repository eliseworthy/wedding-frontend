require "spec_helper"

describe WeddingRequest do
  before(:each) do
    WeddingRequest.base_uri "http://wedding-api.herokuapp.com" 
  end

  describe ".find_all" do
    context "when response is successful" do
      it "returns an array of wedding objects" do
        request = WeddingRequest.find_all
        request.should respond_to :each
      end
    end
    context "when response is not successful" do
      it "returns an error" do
        WeddingRequest.base_uri "http://wrong.wedding-api.herokuapp.com" 
        request = WeddingRequest.find_all
        request.should == "Unable to retrieve weddings."
      end
    end  
  end

  describe ".find" do
    it "returns a wedding object" do
      request = WeddingRequest.find(1)
      request.should be_a Wedding
    end
  end

  describe ".update" do
    context "when passing correct attributes" do 
      pending it "returns a wedding object" do
        #need to do a stand-in here so I don't change the real db
        request = WeddingRequest.update(1, name: "Test")
        request.should be_a Wedding
      end
    end

    context "when passing incorrect attributes" do
      it "returns an error" do
        pending request = WeddingRequest.update(1, description: nil)
        #this returns true but does not update. On API side, looks like it should return error 
      end
    end
  end
end