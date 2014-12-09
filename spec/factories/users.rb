# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do

  sequence(:email) {|n| "user.#{n}@domain.com" }
  sequence(:username) {|n| "username#{n}" }

  factory :user do
    name "Bob Miller"
    username
    email
    phone "333-093-3334"
    designation_overridden "alert"
    linkedin "RaviShankar"
    skype "RaviShankar"
    department
    designation
    biography "A programmer by profession. A student of history and music by passion. Uses Ruby, Python and Javascript. Work as an Web Architect for Qwinix"
    password_digest { SecureRandom.hex }
    password ConfigCenter::Defaults::PASSWORD
    password_confirmation ConfigCenter::Defaults::PASSWORD
  end

  factory :pending_user, parent: :user do
    status "pending"
  end

  factory :approved_user, parent: :user do
    status "approved"
  end

  factory :blocked_user, parent: :user do
    status "blocked"
  end

  factory :admin_user, parent: :user do
    user_type "admin"
  end

end
