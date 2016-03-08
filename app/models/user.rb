class User < ActiveRecord::Base
  rolify
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  validates :name, :surname, presence: true
  after_create :assign_default_role

  has_many :homeworks, inverse_of: :user
  has_many :courses, inverse_of: :lecturer

  def assign_default_role
    add_role(:undergrad)
  end

  def is_master_acc?
    self.id == User.first.id
  end

end
