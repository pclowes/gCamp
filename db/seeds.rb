# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])

#   Mayor.create(name: 'Emanuel', city: cities.first)
Task.destroy_all
User.destroy_all
Project.destroy_all

20.times do
    Project.create name: Faker::Commerce.product_name
end

# 100.times do
#     Task.create description: Faker::Lorem.sentence,
#                 complete: [true, false, true, false].sample,
#                 due: Faker::Time.forward(21),
#                 due_date: Faker::Time.forward(21)
# end

50.times do
    User.create first_name: Faker::Name.first_name,
                last_name: Faker::Name.last_name,
                email: Faker::Internet.email,
                password_digest: Faker::Internet.password
end
