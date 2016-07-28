class LessonsController < ApplicationController

  layout :resolve_layout

  def dashboard
    if @current_user.usertype == "student"
      @lessons = Lesson.all.where(released: "1").order(lesson_number: :asc)
      @assignments = Assignment.all.where(released: "1").order(assignment_number: :asc)
    else
      @lessons = Lesson.all.order(lesson_number: :asc)
    end
  end

  def show
    @lesson = Lesson.find_by id: params[:id]
  end

  def new
    @lesson = Lesson.new
  end

  def create
    @lesson = Lesson.new
    @lesson.lesson_number = params[:lesson][:lesson_number].to_i
    @lesson.title = params[:lesson][:title]
    @lesson.content = params[:lesson][:content]
    @lesson.author = @current_user.full_name
    @lesson.released = params[:lesson][:released]
    @lesson.user_id = @current_user.id
    if @lesson.save

      redirect_to lessons_path
    else
      render :new, notice: "Lesson created"
    end
  end

  def edit
    @lesson = Lesson.find_by id: params[:id]
  end

  def update
    @lesson = Lesson.find_by id: params[:id]
    @lesson.lesson_number = params[:lesson][:lesson_number].to_i
    @lesson.title = params[:lesson][:title]
    @lesson.content = params[:lesson][:content]
    @lesson.author = @current_user.full_name
    @lesson.released = params[:lesson][:released]
    @lesson.user_id = @current_user.id
    if @lesson.save
      redirect_to lessons_path, notice: "Lesson updated"
    else
      flash[:notice] = "Something went wrong saving your update, please make sure all contents are included and try again."
      render :edit
    end

  end

  def delete
    @lesson = Lesson.find_by id: params[:id]
    @lesson.destroy
    redirect_to lessons_path, notice: "Lesson deleted successfully"
  end

end
