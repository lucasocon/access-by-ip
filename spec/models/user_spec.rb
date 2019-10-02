require 'rails_helper'

RSpec.describe User, type: :model do
  it 'should be return responsible full name' do
    company = create(:company)
    admin_user = create(:admin_user, company_id: company.id)

    expect(admin_user.full_name).to eq("First Name Last Name")
  end
end
