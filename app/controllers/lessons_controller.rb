class LessonsController < ApplicationController

  layout :resolve_layout

  def dashboard
    if @current_user.usertype == "student"
      @lessons = get_student_lessons
      @assignments = Assignment.all.where(released: "1").order(assignment_number: :asc)
    else
      @lessons = Lesson.all.order(lesson_number: :asc)
    end
  end

  def show
    @lesson = Lesson.find_by id: params[:id]
    @current_l_number = @lesson.lesson_number
    @last_lesson_number = Lesson.maximum("lesson_number")
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

  def get_student_lessons
    @s_lessons = []
    @lessons_all = Lesson.all.where(released: "1").order(lesson_number: :asc)
    @lessons_all.each do |lesson|
      # 1) if there are no records for this lesson, add them all to student lessons
      if lesson.lessonrecords == []
        @s_lessons << lesson
      else
        #2)for this lesson, if there is no record for this user, add it to student lessons
        if (lesson.lessonrecords.find_by(user_id: @current_user.id) == nil)
          @s_lessons << lesson
        else
          #also, for all the records for this lesson
          lesson.lessonrecords.each do |lrecord|
            #3) if the lesson record is for this user and is not complete, then add it to student lessons
            if (lrecord.user_id == @current_user.id && lrecord.complete == "no")
              @s_lessons << lesson
            end
          end
        end
      end
    end
    return @s_lessons
  end

end
