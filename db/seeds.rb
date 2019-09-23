# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

company = Company.create!(name: "Test")

user = User.create!(email: 'admin@test.com', password: '123456', password_confirmation: '123456', company_id: company.id)

User.create!(email: 'user@email.com', password: '123456', password_confirmation: '123456', company_id: company.id)

company.responsible_id = user.id