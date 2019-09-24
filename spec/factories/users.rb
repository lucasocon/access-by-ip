FactoryBot.define do
  factory :user do
    factory :admin_user do
      email { "admin@test.com" }
      password { "123456" }
      password_confirmation { "123456" }
    end

    factory :tipic_user do
      email { "user@email.com" }
      password { "123456" }
      password_confirmation { "123456" }
    end
  end
end