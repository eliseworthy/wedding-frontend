# require 'spec_helper'

# describe WeddingsController do
#   describe "edit" do
#     it "should be successful" do
#       get :edit, id: 1
#       response.should be_success
#     end
#   end

#   describe "create" do
#     it "should redirect if not logged in" do
#       post :create, {wedding: {description: "Cool", name: "Beans"} }
#       response.should redirect_to root_path
#     end
#     context "logged in" do
#       before(:each) do
#         user = User.create(name: "Elise", email: "hi@hi.com", password: "1", password_confirmation: "1")
#         session[:user_id] = user.id
#       end
#     end
#   end

#   describe "update" do
#     it "should redirect if not logged in" do
#       put :update, {wedding: {description: "Cool", name: "Beans"}, id: 1 }
#       response.should redirect_to root_path
#     end
#   end

#   describe "destroy" do
#     it "should redirect if not logged in" do
#       delete :destroy, { id: 1 }
#       response.should redirect_to root_path
#     end
#   end
# end