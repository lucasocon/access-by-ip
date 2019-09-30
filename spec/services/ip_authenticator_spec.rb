require 'rails_helper'

RSpec.describe 'Ip Authenticator Service' do
  before(:each) do
    @company = create(:company)
    @tipic_user = create(:tipic_user, company_id: @company.id)
    valid_ip = create(:valid_ip)
    @whitelist = create(:whitelist, company_id: @company.id, ips: [valid_ip])
  end

  it 'should return true because the company has not created whitelist' do
    @company.whitelist.destroy
    result = IpAuthenticatorService.new(@tipic_user, "127.0.0.1").call

    expect(result).to eq(true)
  end

  it 'should return true, valid ip' do
    result = IpAuthenticatorService.new(@tipic_user, "127.0.0.1").call

    expect(result).to eq(true)
  end

  it 'should return false, ip not included in the whitelist' do
    result = IpAuthenticatorService.new(@tipic_user, "127.0.15.1").call

    expect(result).to eq(false)
  end
end