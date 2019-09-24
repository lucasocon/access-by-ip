FactoryBot.define do
  factory :company do
    name { "Test" }
    customers_type { "regular" }
    timezone { "UTC" }
  end
end