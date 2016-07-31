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

    @arecord.contentfile = params[:assignmentrecord][:contentfile]
    @arecord.comments = params[:assignmentrecord][:comments]
    @arecord.url_link = params[:assignmentrecord][:url_link]

    @arecord.user_id = @current_user.id
    @arecord.assignment_id = params[:a_id]

    if @arecord.save
      redirect_to lessons_path, notice: "Assignment submitted successfully"
    else
      # flash[:notice] = "Something went wrong saving your assingment, please try again."
      # render :show
      redirect_to assignment_path(id: params[:a_id]), notice: "There was an issue with your submission. Please add a file, URL, or comment"
    end
  end

  def update
    @arecord = Assignmentrecord.find_by id: params[:id]
    @arecord.score = params[:assignmentrecord][:score]
    @arecord.instructor_feedback = params[:assignmentrecord][:instructor_feedback]

    unless (@arecord.score == "" || @arecord.score == nil)
      scorepresent = true
    # else
    #   scorepresent = false
    end

    if scorepresent == true
      @arecord.graded_by = params[:assignmentrecord][:graded_by]
    end

    if (scorepresent == true && @arecord.save)
      redirect_to arecords_path, notice: "Assignment graded"
    else
      flash[:notice] = "Something went wrong. Please input your score and feedback."
      render :show
    end


  end

end
