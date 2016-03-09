class StudentAttendsCourse < ActiveRecord::Base
  belongs_to :courses_attending, :class_name => :Course, inverse_of: :student_attends_courses, :foreign_key => "course_id"
  belongs_to :student, :class_name => :User, inverse_of: :student_attends_courses, :foreign_key => "user_id"
end
