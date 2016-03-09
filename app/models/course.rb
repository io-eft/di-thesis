class Course < ActiveRecord::Base
  belongs_to :lecturer, :class_name => :User, inverse_of: :courses_teaching

  has_many :student_attends_courses, inverse_of: :course, :foreign_key => "course_id"
  has_many :students, :class_name => :User, through: :student_attends_courses, :foreign_key => "course_id"

  has_many :announcements, inverse_of: :course
  has_many :assignments, inverse_of: :course

  validates :code, :name, :lecturer, presence: true
end
