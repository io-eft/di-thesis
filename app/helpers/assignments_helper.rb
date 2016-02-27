module AssignmentsHelper
  def add_documents(course, assignment, id)
    if(assignment.documents.count != 0)
      if(is_course_professor?(course, id))
        render partial: "professor_documents", locals: {documents: assignment.documents}
      else
        render partial: "documents", locals: {documents: assignment.documents}
      end
    end
  end
end
