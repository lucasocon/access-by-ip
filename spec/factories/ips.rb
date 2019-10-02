FactoryBot.define do
  factory :ip do
    factory :my_ip do
      address { "127.0.0.1" }
    end

    factory :another_ip do
      address { "192.168.15.1" }
    end
  end
end
