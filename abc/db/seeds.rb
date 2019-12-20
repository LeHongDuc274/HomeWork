# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
User.create!( name:  "Admin Two",
             email: "admintwo@gmail.com",
             password:              "123456",
             password_confirmation: "123456",
             admin: true,
             activated: true,
             activated_at: Time.zone.now)

99.times do |n|
  User.create!( name: "name - of - #{n+1}",
              email: "example-#{n+1}@gmail.com",
              password: "123456",
              password_confirmation: "123456",
              admin: false,
              activated: true,
              activated_at: Time.zone.now)
end
users = User.order(:created_at).take(6)
3.times  do
    content = "content "
    users.each  { |user|  user.microposts.create!(content:  content)  }
end
