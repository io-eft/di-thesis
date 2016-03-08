class Document < ActiveRecord::Base
  belongs_to :assignment, inverse_of: :documents
  mount_uploader :doc, DocumentUploader
  validates :name, :doc, :assignment, presence: true
end
