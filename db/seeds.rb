# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

users = User.create([{email: 'admin@di.uoa.gr', password: 'admin12345', admin: true}, {email: 'sdi0600296@di.uoa.gr', password: 'abcde12345'}, {email: 'professor@di.uoa.gr', password: 'abcde12345'}])
Lesson.create(name: 'Introduction to Programming', lecturer_id: users[2].id)
