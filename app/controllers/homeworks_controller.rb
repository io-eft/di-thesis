class HomeworksController < ApplicationController
  before_action :set_course, only: [:create, :update, :index]
  before_action :set_assignment, only: [:create, :update, :index]
  before_action :set_homework, only: [:update]
  before_action :get_old_homework, only: [:create, :download]
  before_action :get_all_homework, only: [:index]

  def create
    @homework = @assignment.homeworks.new(homework_params)
    respond_to do |format|
      @homework.user_id = current_user.id
      if @homework.save
        unless @old_hw.nil?
          @old_hw.destroy
        end
        format.html { redirect_to course_assignment_path(@course, @assignment), notice: 'Course was successfully created.' }
      else
        format.js
         format.html { redirect_to course_assignment_path(@course, @assignment), notice: 'There was a problem, please try again.' }
      end
    end
  end

  def update
    respond_to do |format|
      if @homework.update(homework_params)
        format.html { redirect_to @course, notice: 'homework was successfully updated.' }
        format.json { respond_with_bip(@homework) }
      else
        format.html { render :edit }
        format.json { render json: @homework.errors, status: :unprocessable_entity }
      end
    end
  end

  def download
    send_file "#{Rails.root}/public/#{@old_hw.hw}"
  end

  private
    def homework_params
      params.require(:homework).permit(:hw)
    end

    def set_course
      @course = Course.find(params[:course_id])
    end

    def set_assignment
      @assignment = Assignment.find(params[:assignment_id])
    end

    def set_homework
      @homework = Homework.find(params[:id])
    end

    def get_old_homework
      id = params[:i].nil? ? current_user.id : params[:i]
      @old_hw = Homework.where(assignment_id: params[:assignment_id], user_id: id)[0]
    end

    def get_all_homework
      @homework = Homework.where(assignment_id: params[:assignment_id])
    end
end
