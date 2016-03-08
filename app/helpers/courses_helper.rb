module CoursesHelper
  def is_course_professor?(course, id)
    if(id == course.lecturer_id)
      return true;
    else
      return false;
    end
  end
#  helper_method :is_course_professor?

  def index_table
    if(current_user.is_admin?)
      render partial: "admin_table"
    elsif(current_user.is_professor?)
      render partial: "professor_table"
    else
      render partial: "student_table"
    end
  end

  def add_assignments(course)
    if course.assignments.count == 0
      render partial: "no_assignments"
    else
      render partial: "assignments"
    end
  end

  def add_new_assignment(course, id)
    render partial: "new_assignment" if is_course_professor?(course, id)
  end

  def student_attends_course(course, id)
    return !StudentAttendsCourse.where(user_id: id, course_id: course.id).empty?
  end

  def professor_announcements(course, user_id)
    render :partial => "announcements/professor_announcements", locals: {course: course} if is_course_professor?(course, user_id)
  end

  def add_attending_students(course, user_id)
    render :partial => "show_attending_students", locals: {course: course} if is_course_professor?(course, user_id)
  end
end
