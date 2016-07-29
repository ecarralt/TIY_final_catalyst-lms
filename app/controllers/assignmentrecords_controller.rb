class AssignmentrecordsController < ApplicationController
  layout :resolve_layout

  def index
    @arecords = Assignmentrecord.all.where(score: nil)
  end

  def show
    @arecord = Assignmentrecord.find_by id: params[:id]
    @existing_grade = Assignmentrecord.find_by(id: params[:id]).score
  end

  def create
    @arecord = Assignmentrecord.new
    @arecord.contentfile = params[:arecord][:contentfile]
    @arecord.comments = params[:arecord][:comments]
    @arecord.url_link = params[:arecord][:url_link]

    @arecord.user_id = @current_user.id
    @arecord.assignment_id = params[:a_id]

    if @arecord.save
      redirect_to lessons_path, notice: "Assignment submitted successfully"
    else
      # flash[:notice] = "Something went wrong saving your assingment, please try again."
      # render :show
      redirect_to assignment_path(id: params[:id]), notice: "Please try again"
    end
  end

  def update
    @arecord = Assignmentrecord.find_by id: params[:id]
    # @arecord.score = "2"
    @arecord.score = params[:arecord][:score]
    @arecord.instructor_feedback = params[:arecord][:instructor_feedback]
    @arecord.graded_by = params[:arecord][:graded_by]

    if @arecord.save
      redirect_to assignments_path, notice: "Assignment graded"
    else
      flash[:notice] = "Something went wrong saving your grading, please make sure all contents are included and try again."
      render :grade_arecord
    end


  end

end
