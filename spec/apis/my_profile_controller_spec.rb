require "spec_helper"

describe Api::V1::MyProfileController, :type => :controller do

  let(:user) {FactoryGirl.create(:user)}

  it "updates the requested profile" do
    value = user
    patch :update, {:id => user.id, :user => { :name => "Bob Miller", :biography =>"A programmer by profession. A student of history and music by passion. Uses Ruby, Python and Javascript. Work as an Web Architect for Qwinix",:password => ConfigCenter::Defaults::PASSWORD,:password_confirmation => ConfigCenter::Defaults::PASSWORD}}
    expect(value).should_not eq(user)
  end

end

# describe "User - My Profile" , :type => :api do

#   let!(:approved_user) { FactoryGirl.create(:approved_user, name: "Mohandas Gandhi", username: "mohandas", email: "mohandas@gandhi.com", biography: "Father of the nation, India") }
#   let!(:token) { ActionController::HttpAuthentication::Token.encode_credentials(approved_user.auth_token) }
#   let!(:biography) {"Mohandas Karamchand Gandhi was the preeminent leader of Indian nationalism in British-ruled India. Employing nonviolent civil disobedience, Gandhi led India to independence and inspired movements for civil rights and freedom across the world."}
#   let!(:valid_user_information) { {user: {name: "Mohandas Karam Chand Gandhi", biography: biography, password: "Password2", password_confirmation: "Password2"}} }

#   describe "Positive Case" do
#     it "should update the user information with the data sent for valid auth token" do
#       put "/api/v1/my_profile", valid_user_information, :format =>:json, "HTTP_AUTHORIZATION" => token

#       last_response.status.should eql(200)
#       actual_response = symbolize_keys(JSON.parse(last_response.body))
#       actual_response.keys.should eql([:success, :alert, :data])
#       actual_response[:success].should eql(true)
#       actual_response[:alert].should eql("You have successfully registered.")
#       actual_response[:data]["name"].should eql("Mohandas Karam Chand Gandhi")
#       actual_response[:data]["username"].should eql("mohandas")
#       actual_response[:data]["email"].should eql("mohandas@gandhi.com")
#       actual_response[:data]["biography"].should eql(biography)
#       actual_response[:data]["auth_token"].should be_present
#       actual_response[:data]["password"].should be_nil
#       actual_response[:data]["password_digest"].should be_nil

#       post "/api/v1/sign_in", sign_in_credentials(approved_user), :format =>:json
#       last_response.status.should eql(200)
#     end
#   end

#   describe "Negative Case" do

#     it "should return error without token" do
#       put "/api/v1/my_profile", valid_user_information, :format =>:json

#       last_response.status.should eql(200)
#       actual_response = symbolize_keys(JSON.parse(last_response.body))
#       actual_response.keys.should eql([:success, :alert, :data])
#       actual_response[:success].should eql(false)
#       actual_response[:alert].should eql("403 Permission Denied! You don't have permission to perform this action.")
#       actual_response[:data].should be_present

#       actual_response[:data]["errors"]["name"].should eql("AuthenticationError")
#       actual_response[:data]["errors"]["description"].should eql("403 Permission Denied! You don't have permission to perform this action.")
#     end

#     it "should return error for invalid name" do
#       invalid_info = valid_user_information.dup
#       invalid_info[:user][:name] = nil
#       put "/api/v1/my_profile", invalid_info, :format =>:json, "HTTP_AUTHORIZATION" => token

#       last_response.status.should eql(200)
#       actual_response = symbolize_keys(JSON.parse(last_response.body))
#       actual_response.keys.should eql([:success, :alert, :data])
#       actual_response[:success].should eql(false)
#       actual_response[:alert].should eql("Sorry, there are errors with the information you provided. Please review the data you have entered.")
#       actual_response[:data].should be_present

#       actual_response[:data]["errors"]["name"].should eql("ValidationError")
#       actual_response[:data]["errors"]["description"].should eql("Sorry, there are errors with the information you provided. Please review the data you have entered.")
#       actual_response[:data]["errors"]["details"].should eql({"name"=>["can't be blank", "is too short (minimum is 2 characters)"]})
#     end

#     it "should return error for invalid password" do
#       invalid_info = valid_user_information.dup
#       invalid_info[:user][:password] = nil
#       put "/api/v1/my_profile", invalid_info, :format =>:json, "HTTP_AUTHORIZATION" => token
#       last_response.status.should eql(200)
#       actual_response = symbolize_keys(JSON.parse(last_response.body))
#       actual_response.keys.should eql([:success, :alert, :data])
#       actual_response[:success].should eql(false)
#       actual_response[:alert].should eql("Sorry, there are errors with the information you provided. Please review the data you have entered.")
#       actual_response[:data].should be_present

#       actual_response[:data]["errors"]["name"].should eql("ValidationError")
#       actual_response[:data]["errors"]["description"].should eql("Sorry, there are errors with the information you provided. Please review the data you have entered.")
#       actual_response[:data]["errors"]["details"].should eql({"password"=>["is invalid"]})
#     end

#     it "should return error for invalid password confirmation" do
#       invalid_info = valid_user_information.dup
#       invalid_info[:user][:password_confirmation] = nil
#       put "/api/v1/my_profile", invalid_info, :format =>:json, "HTTP_AUTHORIZATION" => token
#       last_response.status.should eql(200)
#       actual_response = symbolize_keys(JSON.parse(last_response.body))
#       actual_response.keys.should eql([:success, :alert, :data])
#       actual_response[:success].should eql(false)
#       actual_response[:alert].should eql("Sorry, there are errors with the information you provided. Please review the data you have entered.")
#       actual_response[:data].should be_present

#       actual_response[:data]["errors"]["name"].should eql("ValidationError")
#       actual_response[:data]["errors"]["description"].should eql("Sorry, there are errors with the information you provided. Please review the data you have entered.")
#       actual_response[:data]["errors"]["details"].should eql({"password_confirmation"=>["can't be blank"]})
#     end

#     it "should return error for password mismatch" do
#       invalid_info = valid_user_information.dup
#       invalid_info[:user][:password_confirmation] = "Some Password"
#       put "/api/v1/my_profile", invalid_info, :format =>:json, "HTTP_AUTHORIZATION" => token
#       last_response.status.should eql(200)
#       actual_response = symbolize_keys(JSON.parse(last_response.body))
#       actual_response.keys.should eql([:success, :alert, :data])
#       actual_response[:success].should eql(false)
#       actual_response[:alert].should eql("Sorry, there are errors with the information you provided. Please review the data you have entered.")
#       actual_response[:data].should be_present

#       actual_response[:data]["errors"]["name"].should eql("ValidationError")
#       actual_response[:data]["errors"]["description"].should eql("Sorry, there are errors with the information you provided. Please review the data you have entered.")
#       actual_response[:data]["errors"]["details"].should eql({"password_confirmation"=>["doesn't match Password"]})
#     end
#   end

# end