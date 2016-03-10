class CoursesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_course, only: [:show, :edit, :update, :destroy, :manage, :description, :attending_students]
  before_action :verify_admin, only: [:new, :destroy]
  before_action :verify_rights, only: [:edit, :update, :manage]
  before_action :get_professors, only: [:new, :edit]
  before_action :verify_student, only: [:enroll, :withdraw]
  before_action :get_attending_students, only: [:attending_students]

  # GET /courses
  # GET /courses.json
  def index
    if(current_user.nil?)
      render file: 'public/403', :status => :forbidden
    end
    @courses = Course.all.paginate(page: params[:page], per_page: 10)
  end

  # GET /courses/1
  # GET /courses/1.json
  def show
  end

  # GET /courses/new
  def new
    @course = Course.new
  end

  # GET /courses/1/edit
  def edit
  end

  def description
    @course.description = params[:description]
    respond_to do |format|
      if @course.save
        format.js { render :description }
      else
        format.js
      end
    end
  end

  # POST /courses
  # POST /courses.json
  def create
    @course = Course.new(course_params)

    respond_to do |format|
      if @course.save
        format.html { redirect_to @course, notice: 'Course was successfully created.' }
        format.json { render :show, status: :created, location: @course }
      else
        get_professors
        format.html { render :new }
        format.json { render json: @course.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /courses/1
  # PATCH/PUT /courses/1.json
  def update
    respond_to do |format|
      if @course.update(course_params)
        format.html { redirect_to @course, notice: 'Course was successfully updated.' }
        format.json { render :show, status: :ok, location: @course }
      else
        format.html { render :edit }
        format.json { render json: @course.errors, status: :unprocessable_entity }
      end
    end
  end

  def enroll
    @course = Course.find(params[:course_id])
    StudentAttendsCourse.create(course_id: @course.id, user_id: current_user.id)
      respond_to do |format|
        format.html { redirect_to "/courses" }
        format.js
      end
  end

  def withdraw
    @course = Course.find(params[:course_id])
    StudentAttendsCourse.where(course_id: @course.id, user_id: current_user.id).each do |s|
      s.delete
    end
      respond_to do |format|
        format.html { redirect_to "/courses" }
        format.js
      end
  end

  # DELETE /courses/1
  # DELETE /courses/1.json
  def destroy
    @course.destroy
    respond_to do |format|
      format.html { redirect_to courses_url, notice: 'Course was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def my_courses
    if current_user.is_professor?
      @courses = current_user.courses_teaching.paginate(page: params[:page], per_page: 10)
      render 'my_courses_professor'
    elsif current_user.is_undergrad?
      @courses = current_user.courses_attending.paginate(page: params[:page], per_page: 10)
      render 'my_courses'
    end
  end

  def attending_students
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_course
      params[:id] = params[:course_id] if params[:id].nil?
      @course = Course.find(params[:id])
    end

    def verify_admin
      unless(current_user != nil && current_user.is_admin?)
        render file: 'public/403', :status => :forbidden
      end
    end

    def verify_rights
      unless(current_user.is_admin? || current_user.id == @course.lecturer_id)
        render file: 'public/403', :status => :forbidden
      end
    end

    def get_professors
      professors = User.with_role :professor
      @professors = []
      professors.each do |a|
        @professors << ["#{a.surname} #{a.name}", a.id]
      end
      @professors.sort! { |a, b| a[0] <=> b[0]}
    end

    def verify_student
      unless(current_user != nil && current_user.is_undergrad?)
        render file: 'public/403', :status => :forbidden
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def course_params
      params.require(:course).permit(:code, :name, :lecturer_id, :description)
    end

    def get_attending_students
      @att_std = Course.find(params[:course_id]).students.paginate(page: params[:page], per_page: 10)
    end
end
