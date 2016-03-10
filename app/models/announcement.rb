class Announcement < ActiveRecord::Base
  belongs_to :course, inverse_of: :announcements
  validates  :title, :message, :course, presence: true
  default_scope { order('updated_at DESC') }
end
