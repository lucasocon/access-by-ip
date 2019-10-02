require 'rails_helper'

RSpec.describe Whitelist, type: :model do
  let(:company) { create( :company) }
  let(:my_ip) { create(:my_ip) }

  it 'whitelist is valid' do
    whitelist = Whitelist.new(name: 'Test', ips: [my_ip], company_id: company.id)
    expect(whitelist).to be_valid
  end

  it 'whitelist is not valid, ips is empty' do
    whitelist = Whitelist.new(name: 'Test', company_id: company.id)
    expect(whitelist).to_not be_valid
  end

  it 'whitelist is not valid, whitelist is nil' do
    whitelist = Whitelist.new(company_id: company.id)
    expect(whitelist).to_not be_valid
  end

  it 'whitelist should be not create, the company already has a whitelist' do
    whitelist_1 = create(:whitelist, company_id: company.id, ips: [my_ip])

    expect{create(:whitelist, company_id: company.id, ips: [my_ip])}.to raise_error(ActiveRecord::RecordInvalid)
  end

  it 'should be create a new whitelist record' do
    whitelist = create(:whitelist, company_id: company.id, ips: [my_ip])

    expect(whitelist.name).to eq("My Whitelist")
    expect(whitelist.ips.size).to eq(1)
  end

  it 'should not create a whitelist because there are repeated ip' do
    whitelist = build(:whitelist, company_id: company.id, ips: [my_ip, my_ip])

    expect(whitelist).to_not be_valid
  end
end
