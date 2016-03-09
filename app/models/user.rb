class User < ActiveRecord::Base
  rolify
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  validates :name, :surname, presence: true
  after_create :assign_default_role

  has_many :homeworks, inverse_of: :user
  has_many :courses_teaching, :class_name => :Course, inverse_of: :lecturer, :foreign_key => "lecturer_id"

  has_many :student_attends_courses, inverse_of: :student, :foreign_key => "user_id"
  has_many :courses_attending, :class_name => :Course, through: :student_attends_courses, :foreign_key => "user_id"

  def assign_default_role
    add_role(:undergrad)
  end

  def is_master_acc?
    self.id == User.first.id
  end

end
