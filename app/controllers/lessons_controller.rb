class LessonsController < ApplicationController

  def dashboard
    @lessons = Lesson.all
  end

  def show
    @lesson = Lesson.find_by id: params[:id]
  end

  def new
    @lesson = Lesson.new
  end

  def create
    @lesson = Lesson.new
    @lesson.title = params[:lesson][:title]
    @lesson.content = params[:lesson][:content]
    @lesson.author = @current_user.full_name
    @lesson.released = params[:lesson][:released]
    @lesson.user_id = @current_user.id
    if @lesson.save
      redirect_to lessons_path
    else
      flash[:notice] = "Something went wrong saving your lesson, please make sure all contents are included and try again."
      render :new
    end
  end

end
