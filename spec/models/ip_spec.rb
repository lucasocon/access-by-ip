require 'rails_helper'

RSpec.describe Ip, type: :model do
  it 'ip is valid' do
    ip = Ip.new(address: '192.168.15.1')
    expect(ip).to be_valid
  end

  it 'ip is not valid, address is not a ip address' do
    ip = Ip.new(address: '124.5454.1215.2')
    expect(ip).to_not be_valid
  end

  it 'ip is not valid, ip is nil' do
    ip = Ip.new
    expect(ip).to_not be_valid
  end

  it 'should be create a new ip record' do
    company = create(:company)
    ip = create(:my_ip)
    whitelist = create(:whitelist, company_id: company.id, ips: [ip])

    expect(ip.whitelist_id).to eq(whitelist.id)
    expect(ip.address).to eq("127.0.0.1")
  end
end
