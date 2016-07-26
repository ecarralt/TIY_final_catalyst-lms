class LessonsController < ApplicationController

  def dashboard
    @lessons = Lesson.all.order(lesson_number: :asc)
  end

  def show
    @lesson = Lesson.find_by id: params[:id]
  end

  def new
    @lesson = Lesson.new
  end

  def create
    @lesson = Lesson.new
    @lesson.lesson_number = params[:lesson][:lesson_number]
    @lesson.title = params[:lesson][:title].to_i
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
