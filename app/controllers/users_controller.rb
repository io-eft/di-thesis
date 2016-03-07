class UsersController < ApplicationController
  before_action :set_user, only: [:give_role]
  before_action :set_hashes

  def index
    unless(current_user != nil && current_user.is_admin?)
      render file: 'public/403', :status => :forbidden
    end
    @users = User.all.paginate(page: params[:page], per_page: 10)
  end

  def make_admin
    @user.add_role(:admin)
    respond_to do |format|
      format.js
    end
  end

  def make_professor
    @user.add_role(:professor)
    respond_to do |format|
      format.js
    end
  end

  def make_student
    @user.add_role(:undergrad)
    respond_to do |format|
      #format.html { redirect_to "/users" }
      format.js
    end
  end

  def give_role
    @user.add_role(@role)
    respond_to do |format|
      format.js
    end
  end


  private
    def set_user
      @user = User.find(params[:user_id])
      @user.roles = []
      @role = params[:rol]
    end

    def set_hashes
      @colours = {
        "admin" => "danger",
        "professor" => "warning",
        "undergrad" => "info"
      }

      @drop_roles = [
        "admin",
        "professor",
        "undergrad"
      ]
    end
end
