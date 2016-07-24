

# User.delete_all
user = User.new username: "ecarralt", password: "12345678", email: "ecarralt@gmail.com", first_name: "Enrique", last_name: "Carral", usertype: "student"
user.save!
user2 = User.new username: "george", password: "12345678", email: "george@gmail.com", first_name: "George", last_name: "Clooney", usertype: "student"
user2.save!
user3 = User.new username: "harry", password: "12345678", email: "harry@gmail.com", first_name: "Harry", last_name: "Potter", usertype: "teacher"
user3.save!


# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
