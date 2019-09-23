FactoryBot.define do
  factory :company do
    name { "MyString" }
    responsable_id { 1 }
    has_pip_features { false }
    customers_type { "MyString" }
    timezone { "MyString" }
    parcel_index_report_view_id { 1 }
  end
end
