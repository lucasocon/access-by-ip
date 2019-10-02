require 'rails_helper'

RSpec.describe 'Create a new session' do
  let(:company) { create( :company) }
  let!(:tipic_user) { create(:tipic_user, company_id: company.id) }
  let!(:admin_user) { create(:admin_user, company_id: company.id) }
  let(:another_ip) { create(:another_ip) }
  let!(:whitelist) { create(:whitelist, company_id: company.id, ips: [another_ip]) }

  it 'should not can sign in by invalid ip' do
    visit "users/sign_in"

    fill_in 'user_email', with: "tipic_user@email.com"
    fill_in 'user_password', with: "123456"
    find("input[type='submit']").click

    expect(page).to have_content("You cannot access from your ip")
  end

  it 'should can sign in with valid ip' do
    ip2 = create(:my_ip)
    whitelist.ips << ip2

    visit "users/sign_in"

    fill_in 'user_email', with: "tipic_user@email.com"
    fill_in 'user_password', with: "123456"
    find("input[type='submit']").click

    expect(page).to have_content("Signed in successfully")
  end

  it 'admin can access from all ips' do
    company.responsible_id = admin_user.id
    company.save!

    visit "users/sign_in"

    fill_in 'user_email', with: "admin_user@test.com"
    fill_in 'user_password', with: "123456"
    find("input[type='submit']").click

    expect(page).to have_content("Signed in successfully")
  end


  it 'company without whitelist allows all ips requests' do
    company.whitelist.destroy

    visit "users/sign_in"

    fill_in 'user_email', with: "tipic_user@email.com"
    fill_in 'user_password', with: "123456"
    find("input[type='submit']").click

    expect(page).to have_content("Signed in successfully")
  end
end