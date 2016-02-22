class Document < ActiveRecord::Base
  belongs_to :assignment, inverse_of: :documents
  mount_uploader :doc, DocumentUploader
end
