module AssignmentsHelper
  def add_document_link(name)
#    link_to_function name do |page|
#      page.insert_html :bottom, :documents, :partial => 'document', :object => Document.new
#    end
    insert_html(:bottom, "documents", "<div>adwaaw</div>")

  end
end
