class Course < ActiveRecord::Base
  belongs_to :lecturer, :class_name => :User, :foreign_key => "user_id"
  has_many :students, through: :student_attends_courses, inverse_of: :course
  has_many :announcements, inverse_of: :course
  has_many :assignments, inverse_of: :course
  validates :code, :name, :lecturer_id, presence: true
end
