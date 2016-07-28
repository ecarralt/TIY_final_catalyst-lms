class AssignmentsController < ApplicationController

  layout :resolve_layout


  def index
    if @current_user.usertype == "student"
      @assignments = Assignment.all.where(released: "1").order(assignment_number: :asc)
    else
      @assignments = Assignment.all.order(assignment_number: :asc)
    end
  end

  def show
    @assignment = Assignment.find_by id: params[:id]
    @assignmentrecord = Assignmentrecord.new
    @existing_record = Assignmentrecord.find_by(assignment_id: params[:id],  user_id: @current_user.id)
    # if existing_record
    #   @alreadysubmitted = true
    # else
    #   @alreadysubmitted = false
    # end
  end

  def new
    @assignment = Assignment.new
  end

  def create
    @assignment = Assignment.new
    @assignment.assignment_number = params[:assignment][:assignment_number].to_i
    @assignment.title = params[:assignment][:title]
    @assignment.content = params[:assignment][:content]
    @assignment.author = @current_user.full_name
    @assignment.released = params[:assignment][:released]
    @assignment.user_id = @current_user.id
    if @assignment.save

      redirect_to assignments_path
    else
      render :new, notice: "Assignment created"
    end
  end

  def edit
    @assignment = Assignment.find_by id: params[:id]
  end

  def update
    @assignment = Assignment.find_by id: params[:id]
    @assignment.assignment_number = params[:assignment][:assignment_number].to_i
    @assignment.title = params[:assignment][:title]
    @assignment.content = params[:assignment][:content]
    @assignment.author = @current_user.full_name
    @assignment.released = params[:assignment][:released]
    @assignment.user_id = @current_user.id
    if @assignment.save
      redirect_to assignments_path, notice: "Assignment updated"
    else
      flash[:notice] = "Something went wrong saving your update, please make sure all contents are included and try again."
      render :edit
    end

  end

  def delete
    @assignment = Assignment.find_by id: params[:id]
    @assignment.destroy
    redirect_to assignments_path, notice: "Assignment deleted successfully"
  end

  def create_record
    @assignmentrecord = Assignmentrecord.new
    @assignmentrecord.contentfile = params[:assignmentrecord][:contentfile]
    @assignmentrecord.comments = params[:assignmentrecord][:comments]
    @assignmentrecord.url_link = params[:assignmentrecord][:url_link]

    @assignmentrecord.user_id = @current_user.id
    @assignmentrecord.assignment_id = params[:id]

    if @assignmentrecord.save
      redirect_to lessons_path, notice: "Assignment submitted successfully"
    else
      # flash[:notice] = "Something went wrong saving your assingment, please try again."
      # render :show
      redirect_to assignment_path(id: params[:id]), notice: "Please try again"
    end
  end

end
