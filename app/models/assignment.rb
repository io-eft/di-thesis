class Assignment < ActiveRecord::Base
  belongs_to :course, inverse_of: :assignments
  has_many :documents, inverse_of: :assignment, :dependent => :destroy
  has_many :homeworks, inverse_of: :assignment, :dependent => :destroy
  accepts_nested_attributes_for :documents
  validates :title, :description, :due_date, :course, presence: true
  validates_associated :documents
end
