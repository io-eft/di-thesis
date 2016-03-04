module AssignmentsHelper
  def add_documents(course, assignment, id)
    if(is_course_professor?(course, id))
      render partial: "professor_documents", locals: {documents: assignment.documents}
    elsif(assignment.documents.count != 0)
      render partial: "documents", locals: {documents: assignment.documents}
    end
  end

  def delete_button(course, id)
    render partial: "delete_assignment" if is_course_professor?(course, id)
  end

  def add_homework(course, assignment, id)
    if student_attends_course(course, id)
      hmwk = get_submitted_hw(assignment.id, id)
      if has_expired?(assignment)
        #hmwk = Homework.where(user_id: id, assignment_id: assignment.id)[0]
        #hmwk = Homework.where(assignment_id: assignment.id, user_id: id)
        if hmwk.nil?
          color = "danger"
          exp_hw = "The assignment has expired, and you have not submitted your work."
        else
          color = "success"
          exp_hw = "The assignment has expired, and you have submitted: #{hmwk.hw.to_s.split('/').last}"
        end
        render partial: "expired_homework", locals: {course: course, assignment: assignment, exp_hw: exp_hw, color: color}
      else
        if hmwk.nil?
          submitted = ""
          color = "success"
        else
          submitted = "You've already submitted this on #{hmwk.created_at.strftime("%m/%d/%Y, %H:%M")}. Submitting it again will overwrite the previous submission."
          color = "primary"
        end
        render partial: "homework", locals: {course: course, assignment: assignment, submitted: submitted, color: color}
      end
    end
  end

  def has_expired?(assignment)
    return Time.now > assignment.due_date.end_of_day
  end

  def time_left?(assignment)
    time = assignment.due_date.end_of_day - Time.now
    if time < 0
      color = "#a94442;"
      time_left = " (Expired)"
    else
      color = "#3c763d;"
      time_left = " (#{distance_of_time_in_words(time)})"
    end
    render partial: "assignments/time_left", locals: {time_left: time_left, color: color}
  end
end
