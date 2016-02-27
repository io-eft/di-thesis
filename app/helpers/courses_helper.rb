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

end
