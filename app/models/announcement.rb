class Announcement < ActiveRecord::Base
  belongs_to :course, inverse_of: :announcements
  default_scope {order('updated_at DESC')}
end
