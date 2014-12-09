require 'spec_helper'

describe Admin::DesignationsController, :type => :controller do


  let(:designation) {FactoryGirl.create(:designation)}
  let(:admin_user) {FactoryGirl.create(:admin_user, :name => "testuser", :username =>"username", :email =>"abcd@yopmail.com", :biography => "Hi this is lorem ipsum", :password =>  ConfigCenter::Defaults::PASSWORD, :password_confirmation =>  ConfigCenter::Defaults::PASSWORD, :user_type =>"super_admin" )}

  before(:each) do
   session[:id] = admin_user.id
 end

 it "POST #create" do
  designation_params = {
   designation: {
    title: "Developer",
    responsibilities: "Quality code"
  }
}
session[:id] = admin_user.id
post :create, designation_params
expect(Designation.count).to  eq 1
end

it "assigns all get_collections as @designations" do
  get :index
  assigns(:designations).should eq([designation])
end

it "GET #edit" do
 get :edit, {:id => designation.id}
 assigns(:designation).should eq(designation)
end

it "GET #show" do
 get :show, {:id => designation.id}
 expect(assigns(:designation)).to eq(designation)
end

it "updates the requested designation" do
  value = designation
  patch :update, {:id => designation.id, :designation => { :title => "New title", :responsibilities =>"Tested data"}}
  expect(value).should_not eq(designation)
end

it "destroys the requested designation" do
  value = designation
  expect do
    delete :destroy, {:id => designation.id}
  end.to change(Designation, :count).by(-1)
end

end