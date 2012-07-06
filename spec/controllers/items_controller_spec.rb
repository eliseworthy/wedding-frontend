# require 'spec_helper'

# describe ItemsController do
#   describe "edit" do
#     it "should be successful" do
#       get :edit, id: 1
#       response.should be_success
#     end
#   end

#   describe "create" do
#     it "should redirect if not logged in" do
#       post :create, {item: {description: "Cool"} }
#       response.should redirect_to root_path
#     end
#     context "logged in" do
#       before(:each) do
#         user = User.create(name: "Elise", email: "hi@hi.com", password: "1", password_confirmation: "1")
#         session[:user_id] = user.id
#         @wedding = Wedding.new(user_id: user.id)
#         WeddingRequest.stub(:find).with("1") { @wedding }
#         request.env["HTTP_REFERER"] = "hometown"
#       end

#       it "should correctly assign wedding" do
#         post :create, {item: {description: "Cool", wedding_id: "1"} }
#         assigns(:wedding).should == @wedding
#       end

#       context "when user is curent_user" do
#         # before(:each) do
#         #   user = User.create(name: "Elise", email: "hi@hi.com", password: "1", password_confirmation: "1")
#         #   item = HTTParty::StubResponse.new
#         #   @wedding = Wedding.new(user_id: user.id)
#         #   WeddingRequest.stub(:find).with("1") { @wedding }
#         #   ItemRequest.stub(:create).with({description: "hi", wedding_id: "1"}, "1") { item }
#         #   item.stub(:success?) { true }
#         #   post :create, {item: {description: "hi", wedding_id: "1"}}, {api_key: "1"}
#         # end
#         # it "creates the item", focus: true do
#         #   @controller.instance_eval{flash.stub!(:sweep)}
#         #   flash.now[:notice].should_not be_nil
#         # end
#       end

#       context "when user isn't current_user" do
#         before(:each) do
#           @wedding = Wedding.new(user_id: 2)
#           WeddingRequest.stub(:find).with("1") { @wedding }
#         end
#         it "redirects back to the referring page" do
#           post :create, {item: {description: "Cool", wedding_id: "1"} }
#           response.should redirect_to "hometown"
#         end
#       end
#     end
#   end

#   describe "update" do
#     it "should redirect if not logged in" do
#       put :update, {item: {description: "Cool"}, id: 1 }
#       response.should redirect_to root_path
#     end

#     context "when user isn't current_user" do
#       # before(:each) do
#       #   @wedding = Wedding.new(user_id: 2)
#       #   WeddingRequest.stub(:find).with("1") { @wedding }
#       #   request.env["HTTP_REFERER"] = "hometown"
#       # end

#       # it "redirects back to the referring page" do
#       #   put :update, {item: {description: "Cool", wedding_id: "1"}, id: 1 }
#       #   response.should redirect_to "hometown"
#       # end

#     end
#   end

#   describe "destroy" do
#     it "should redirect if not logged in" do
#       delete :destroy, { id: 1 }
#       response.should redirect_to root_path
#     end
#   end
# end