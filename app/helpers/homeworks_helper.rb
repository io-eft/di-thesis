module HomeworksHelper
  def get_submitted_hw(assignment_id, user_id)
    return Homework.where(assignment_id: assignment_id, user_id: user_id)[0]
  end

  def download_homework(course, assignment, user_id)
    hw = get_submitted_hw(assignment.id, user_id)
    render partial: "download_homework", locals: {course: course, assignment: assignment, hw: hw} unless hw.nil?
  end

  def get_student_homework(course, assignment, user_id)
    hw = get_submitted_hw(assignment.id, user_id)
    render partial: "get_student_homework", locals: {course: course, assignment: assignment, hw: hw, i: user_id} unless hw.nil?
  end
end
