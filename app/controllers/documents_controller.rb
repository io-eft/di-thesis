class DocumentsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_course
  before_action :set_assignment
  before_action :set_document, only: [:update, :destroy]
  before_action :set_id_to_remove, only: [:destroy]

  def update
    respond_to do |format|
      if @document.update(document_params)
        format.html { redirect_to course_assignment_path(@course, @assignment), notice: 'Document was successfully updated.' }
        format.json { respond_with_bip(@document) }
      else
        format.html { render :edit }
        format.json { render json: @document.errors, status: :unprocessable_entity }
      end
    end
  end

  def add_document
    @new_doc = @assignment.documents.new(document_params)
    respond_to do |format|
      if @new_doc.save
        format.html { redirect_to course_assignment_path(@course, @assignment), notice: "Document Added!"}
        format.js
      else
        redirect_to @assignment, notice: "There has been an error adding the document"
      end
    end
  end

  def destroy
    @document.remove_doc!
    @document.save
    @document.destroy
    respond_to do |format|
      format.html { redirect_to course_assignment_path(@course, @assignment)}
      format.js
      format.json { head :no_content }
    end
  end

  private
    def document_params
      params.require(:document).permit(:name, :doc)
    end

    def set_course
      @course = Course.find(params[:course_id])
    end

    def set_assignment
      @assignment = Assignment.find(params[:assignment_id])
    end

    def set_document
      @document = Document.find(params[:id])
    end

    def set_id_to_remove
      @id_to_remove = params[:id]
    end
end
