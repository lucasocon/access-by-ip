FactoryBot.define do
  factory :user do
    factory :admin_user do
      email { "admin_user@test.com" }
      first_name { "First Name"}
      last_name { "Last Name"}
      password { "123456" }
      password_confirmation { "123456" }
    end

    factory :tipic_user do
      email { "tipic_user@email.com" }
      password { "123456" }
      password_confirmation { "123456" }
    end
  end
end