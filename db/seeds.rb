# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

users = User.create([
  {name: Faker::Name.first_name, surname: Faker::Name.last_name, email: 'admin@di.uoa.gr', password: 'admin12345'},
  {name: Faker::Name.first_name, surname: Faker::Name.last_name, email: 'sdi0600296@di.uoa.gr', password: 'admin12345'},
  {name: Faker::Name.first_name, surname: Faker::Name.last_name, email: 'professor@di.uoa.gr', password: 'admin12345'},
  {name: Faker::Name.first_name, surname: Faker::Name.last_name, email: 'sdi0600297@di.uoa.gr', password: 'admin12345'},
  {name: Faker::Name.first_name, surname: Faker::Name.last_name, email: 'professor2@di.uoa.gr', password: 'admin12345'}
  ])

users[0].add_role :admin
users[2].add_role :professor
users[1].add_role :undergrad
users[3].add_role :undergrad
users[4].add_role :professor

courses = Course.create([
  {code: "C01", name: 'Introduction to Programming', lecturer_id: users[2].id, description: Faker::Lorem.paragraphs(1 + rand(4).join("\n"))},
  {code: "C02", name: 'Introduction to Programming 2', lecturer_id: users[2].id, description: Faker::Lorem.paragraphs(1 + rand(4).join("\n"))},
  {code: "C03", name: 'Introduction to Programming 3', lecturer_id: users[4].id, description: Faker::Lorem.paragraphs(1 + rand(4).join("\n"))}
  ])

StudentAttendsCourse.create([
  {user_id: users[1].id, course_id: courses[0].id},
  {user_id: users[3].id, course_id: courses[0].id},
  {user_id: users[1].id, course_id: courses[1].id},
  {user_id: users[3].id, course_id: courses[2].id}
  ])

  courses.each do |course|
    for i in 1..2 + rand(25) do
      course.announcements.create(
        title: Faker::Lorem.sentence
        message: Faker::Lorem.paragraphs.join("\n")
      )
    end

    for i in 1..1 + rand(5) do
      course.assignment.create(
        title: Faker::Lorem.sentence
        description: Faker::Lorem.paragraphs(4).join("\n")
        due_date: Faker::Date.between(15.days.ago, 45.days.from_now)
      )
    end
  end
