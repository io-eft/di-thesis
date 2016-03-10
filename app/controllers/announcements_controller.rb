class AnnouncementsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_course, only: [:create, :update]
  before_action :set_announcement, only: [:update]
  def create
    @announcement = @course.announcements.new(announcement_params)
    respond_to do |format|
      if @announcement.save
        format.js { render :create }
        # format.html { redirect_to @course, notice: 'Course was successfully created.' }
        # format.json { render :show, status: :created, location: @announcement }
      else
        format.js { render 'error' }
        # format.html { render :new }
        # format.json { render json: @announcement.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @announcement.update(announcement_params)
        format.html { redirect_to @course, notice: 'Announcement was successfully updated.' }
        format.json { respond_with_bip(@announcement) }
      else
        format.html { render :edit }
        format.json { render json: @announcement.errors, status: :unprocessable_entity }
      end
    end
  end

  private
    def announcement_params
      params.require(:announcement).permit(:title, :message)
    end

    def set_course
      @course = Course.find(params[:course_id])
    end

    def set_announcement
      @announcement = Announcement.find(params[:id])
    end
end
