class AssignmentsController < ApplicationController
  before_action :set_course
  before_action :set_assignment, only: [:show, :edit, :update, :destroy, :add_document]
  before_action :set_document, only: [:download]
  # GET /assignments
  # GET /assignments.json
  def index
    @assignments = Assignment.all
  end

  # GET /assignments/1
  # GET /assignments/1.json
  def show
  end

  # GET /assignments/new
  def new
    #@assignment = Assignment.new
    @assignment = @course.assignments.build
  end

  # GET /assignments/1/edit
  def edit
  end

  # POST /assignments
  # POST /assignments.json
  def create
    @assignment = @course.assignments.new(assignment_params)
    #@assignment.documents.last.name = @assignment.documents.last.doc
    respond_to do |format|
      if @assignment.save
        format.html { redirect_to @course, notice: 'Assignment was successfully created.' }
        format.json { render :show, status: :created, location: @assignment }
      else
        format.html { render :new }
        format.json { render json: @assignment.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /assignments/1
  # PATCH/PUT /assignments/1.json
  def update
    respond_to do |format|
      if @assignment.update(assignment_params)
        format.html { redirect_to course_assignment_path(@course, @assignment), notice: 'Assignment was successfully updated.' }
        format.json { respond_with_bip(@assignment) }
      else
        format.html { render :edit }
        format.json { render json: @assignment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /assignments/1
  # DELETE /assignments/1.json
  def destroy
    if(@course.lecturer_id == current_user.id)
      @assignment.destroy
      respond_to do |format|
        format.html { redirect_to @course, notice: 'Assignment was successfully destroyed.' }
        format.json { head :no_content }
      end
    end
  end

  def download
    send_file "#{Rails.root}/public//#{@doc.doc}"
    #send_file "#{Rails.root}/public/uploads/document/doc/#{@course.id}/#{@assignment.id}/#{@doc.doc}"
  end

  private
    def set_course
      @course = Course.find(params[:course_id])
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_assignment
      id = params[:id].nil? ? params[:assignment_id] : params[:id]
      @assignment = Assignment.find(id)
      #@assignment = Assignment.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def assignment_params
      params.require(:assignment).permit(:title, :description, :due_date, :course_id, documents_attributes: [:name, :doc, :_destroy])
    end

    def set_document
      @assignment = Assignment.find(params[:assignment_id])
      @doc = Document.find(params[:document_id])
    end
end