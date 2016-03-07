module ApplicationHelper
  def add_role_button(user)
    if(user == User.first)
      render partial: 'master_account'
    else
      role =
      if user.is_admin?
        "admin"
      #  render partial: "users/admin"
      elsif user.is_professor?
        "professor"
      #  render partial: "users/professor", locals: {user: user}
      elsif user.is_undergrad?
        "undergrad"
      #  render partial: "users/undergrad"
      end
      render partial: 'role', locals: { user: user, role: role}
    end
  end
end
