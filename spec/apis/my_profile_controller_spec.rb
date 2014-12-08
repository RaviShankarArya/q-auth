require "spec_helper"

describe Api::V1::MyProfileController, :type => :controller do

  let(:user) {FactoryGirl.create(:user)}

  it "updates the requested profile" do
    value = user
    put :update, {:id => user.id, :user => { :name => "Bob Miller", :biography =>"A programmer by profession. A student of history and music by passion. Uses Ruby, Python and Javascript. Work as an Web Architect for Qwinix",:password => ConfigCenter::Defaults::PASSWORD,:password_confirmation => ConfigCenter::Defaults::PASSWORD}}
    expect(value).should_not eq(user)
  end

  it "GET #user_detail" do
    [user]
    request.env['HTTP_AUTHORIZATION'] = "Token token=#{user.auth_token}"
    get :user_detail, {:auth_token => user.auth_token}
    (assigns(:user)).should eq(user)
  end
end

