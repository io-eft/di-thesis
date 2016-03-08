class UsersController < ApplicationController
  before_action :set_user, only: [:give_role]
  before_action :set_hashes

  def index
    unless(current_user != nil && current_user.is_admin?)
      render file: 'public/403', :status => :forbidden
    end
    @users = User.all.paginate(page: params[:page], per_page: 10)
  end

  def give_role
    @user.add_role(@role) unless @user.is_master_acc?
    respond_to do |format|
      format.js
    end
  end


  private
    def set_user
      @user = User.find(params[:user_id])
      @user.roles = [] unless @user.is_master_acc?
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
