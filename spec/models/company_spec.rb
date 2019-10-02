require 'rails_helper'

RSpec.describe Company, type: :model do
  it 'should return all the ips at the whitelist of the company' do
    company = create(:company)
    ip = create(:my_ip)
    whitelist = create(:whitelist, company_id: company.id, ips: [ip])

    expect(company.whitelist_ips).to eq([ip])
  end
end