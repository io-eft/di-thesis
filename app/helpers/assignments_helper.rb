module AssignmentsHelper
  def add_documents(course, assignment)
    if(assignment.documents.count != 0)
      render partial: "documents", locals: {documents: assignment.documents}
    end
  end
end
