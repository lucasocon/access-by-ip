FactoryBot.define do
  factory :ip do
    factory :valid_ip do
      address { "127.0.0.1" }
    end

    factory :invalid_ip do
      address { "192.168.15.1" }
    end
  end
end
