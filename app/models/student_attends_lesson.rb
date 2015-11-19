class StudentAttendsLesson < ActiveRecord::Base
  belongs_to :student, :class_name => :User, :foreign_key => "user_id"
  belongs_to :lesson
end
