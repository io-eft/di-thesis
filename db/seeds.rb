# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

users = User.create([{name: "FirstName", surname: "Surname", email: 'admin@di.uoa.gr', password: 'admin12345'}, {name: "FirstName", surname: "Surname", email: 'sdi0600296@di.uoa.gr', password: 'abcde12345'}, {name: "FirstName", surname: "Surname", email: 'professor@di.uoa.gr', password: 'abcde12345'}])
users[0].add_role :admin
users[2].add_role :professor
Course.create(code: "C01", name: 'Introduction to Programming', lecturer_id: users[2].id)
