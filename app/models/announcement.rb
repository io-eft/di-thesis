class Announcement < ActiveRecord::Base
  belongs_to :user
  belongs_to :course
  default_scope {order('updated_at DESC')}
end
