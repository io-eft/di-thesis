# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

sid = 150
prof = 3
adm = 1

users = User.create([
  {name: Faker::Name.first_name, surname: Faker::Name.last_name, email: 'admin@di.uoa.gr', password: 'admin12345'},
  {name: Faker::Name.first_name, surname: Faker::Name.last_name, email: 'sdi0600296@di.uoa.gr', password: 'admin12345'},
  {name: Faker::Name.first_name, surname: Faker::Name.last_name, email: 'professor@di.uoa.gr', password: 'admin12345'},
  {name: Faker::Name.first_name, surname: Faker::Name.last_name, email: 'sdi0600297@di.uoa.gr', password: 'admin12345'},
  {name: Faker::Name.first_name, surname: Faker::Name.last_name, email: 'professor2@di.uoa.gr', password: 'admin12345'}
  ])

  usid = [users[1].id, users[3].id]
  prid = [users[2].id, users[4].id]

for i in 1..40
    r = ""
  case rand(3)
  when 0
    em = "professor#{prof += 1}@di.uoa.gr"
    r = "professor"
  when 1
    em = "sdi0#{rand(9)}00#{sid += 1}@di.uoa.gr"
    r = "undergrad"
  when 2
    em = "admin#{adm += 1}@di.uoa.gr"
    r = "admin"
  end
  u = User.create(name: Faker::Name.first_name, surname: Faker::Name.last_name, email: em, password: 'admin12345')
  u.roles = []
  u.add_role r
  case r
  when "professor"
    prid << u.id
  when "undergrad"
    usid << u.id
  end
end

for i in 1..4
  users[i].roles = []
end

users[0].add_role :admin
users[2].add_role :professor
users[1].add_role :undergrad
users[3].add_role :undergrad
users[4].add_role :professor

courses = Course.create([
  {code: "C01", name: 'Introduction to Programming', lecturer_id: users[2].id, description: Faker::Lorem.paragraphs(1 + rand(4)).join("\n")},
  {code: "C02", name: 'Introduction to Programming 2', lecturer_id: users[2].id, description: Faker::Lorem.paragraphs(1 + rand(4)).join("\n")},
  {code: "C03", name: 'Introduction to Programming 3', lecturer_id: users[4].id, description: Faker::Lorem.paragraphs(1 + rand(4)).join("\n")}
  ])

  for i in 4..25
    courses << Course.create(code: ("C%02d" % i),
                  name: Faker::Lorem.words(2 + rand(3), true).join(' ').capitalize,
                  lecturer_id: prid[rand(prid.size)],
                  description: Faker::Lorem.paragraphs(1 + rand(4)).join("\n"))
  end
#
# StudentAttendsCourse.create([
#   {user_id: users[1].id, course_id: courses[0].id},
#   {user_id: users[3].id, course_id: courses[0].id},
#   {user_id: users[1].id, course_id: courses[1].id},
#   {user_id: users[3].id, course_id: courses[2].id}
#   ])

  courses.each do |course|
    usid.each do |user|
      StudentAttendsCourse.create(user_id: user, course_id: course.id) if rand(2) == 1
    end

    for i in 1..2 + rand(25) do
      course.announcements.create(
        title: Faker::Lorem.sentence,
        message: Faker::Lorem.paragraphs.join("\n")
      )
    end

    for i in 1..1 + rand(5) do
      course.assignments.create(
        title: Faker::Lorem.sentence,
        description: Faker::Lorem.paragraphs(4).join("\n"),
        due_date: Faker::Date.between(15.days.ago, 45.days.from_now)
      )
    end
  end
