class Assignment < ActiveRecord::Base
  belongs_to :course, inverse_of: :assignments
  has_many :documents, inverse_of: :assignment
  accepts_nested_attributes_for :documents
end
