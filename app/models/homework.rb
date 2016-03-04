class Homework < ActiveRecord::Base
  belongs_to :user
  belongs_to :assignment, inverse_of: :documents
  mount_uploader :hw, HomeworkUploader
end
