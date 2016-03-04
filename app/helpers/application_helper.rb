module ApplicationHelper
  def add_role_button(user)
    role = ''
    if user.is_admin?
      role = "admin"
    #  render partial: "users/admin"
    elsif user.is_professor?
      role = "professor"
    #  render partial: "users/professor", locals: {user: user}
    elsif user.is_undergrad?
      role = "undergrad"
    #  render partial: "users/undergrad"
    end
    render partial: 'role', locals: { user: user, role: role}
  end
end
