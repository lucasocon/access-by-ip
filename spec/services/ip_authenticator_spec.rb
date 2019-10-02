require 'rails_helper'

RSpec.describe 'Ip Authenticator Service' do
  let(:company) { create( :company) }
  let!(:tipic_user) { create(:tipic_user, company_id: company.id) }
  let!(:admin_user) { create(:admin_user, company_id: company.id) }
  let(:my_ip) { create(:my_ip) }
  let!(:whitelist) { create(:whitelist, company_id: company.id, ips: [my_ip]) }

  it 'should return true because the company has not created whitelist' do
    company.whitelist.destroy
    result = IpAuthenticatorService.new(tipic_user, "127.0.0.1").call

    expect(result).to eq(true)
  end

  it 'should return true, valid ip' do
    result = IpAuthenticatorService.new(tipic_user, "127.0.0.1").call

    expect(result).to eq(true)
  end

  it 'should return false, ip not included in the whitelist' do
    result = IpAuthenticatorService.new(tipic_user, "127.0.15.1").call

    expect(result).to eq(false)
  end
end