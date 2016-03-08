class Homework < ActiveRecord::Base
  belongs_to :user
  belongs_to :assignment, inverse_of: :homeworks
  mount_uploader :hw, HomeworkUploader
  validates :user, :assignment, :hw, presence: true
end
