# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

10.times do |n|
  name = "user"
  email = "user#{n+1}@example.com"
  password = "password"
  User.create!(name: name,
               email: email,
               password: password,
               )
end

10.times do |i|
  Label.create!(name: "sample#{i + 1}")
end

10.times do |n|
  title = "sample#{n + 1}"
  content = "sample#{n + 1}"
  due_date = Time.zone.now + (20 + n).days
  status = rand(0..2)
  priority = rand(0..2)

  Task.create!(title: title,
                content: content,
                due_date: due_date,
                status: status,
                priority: priority,
                user_id: 11
                )
end