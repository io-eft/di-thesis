class Course < ActiveRecord::Base
  belongs_to :lecturer, :class_name => :User, :foreign_key => "user_id"
  has_many :students, through: :student_attends_courses
  has_many :announcements, inverse_of: :course
  has_many :assignments, inverse_of: :course
end
