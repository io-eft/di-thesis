class StudentAttendsCourse < ActiveRecord::Base
  belongs_to :student, :class_name => :User, :foreign_key => "user_id"
  belongs_to :course, inverse_of: :student_attends_courses
end
