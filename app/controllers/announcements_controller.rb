class AnnouncementsController < ApplicationController
  def create
    @course = Course.find(params[:course_id])
    @announcement = @course.announcements.new(announcement_params)
    @announcement.user_id = current_user.id

    respond_to do |format|
      if @announcement.save
        format.js { render :create }
        # format.html { redirect_to @course, notice: 'Course was successfully created.' }
        # format.json { render :show, status: :created, location: @announcement }
      else
        format.js
        # format.html { render :new }
        # format.json { render json: @announcement.errors, status: :unprocessable_entity }
      end
    end
  end

  private
    def announcement_params
      params.require(:announcement).permit(:title, :message)
    end
end
