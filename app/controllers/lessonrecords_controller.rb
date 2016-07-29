class LessonrecordsController < ApplicationController

  def create

    @lrecord = Lessonrecord.new
    @lrecord.complete = "yes"
    @lrecord.lesson_id = params[:l_id]
    @lrecord.user_id = params[:u_id]

    if @lrecord.save
      #Preparing redirection to next lesson
      @prevlesson = Lesson.find_by id: params[:l_id]
      max_lesson_number = Lesson.maximum("lesson_number")

      if @prevlesson.lesson_number < max_lesson_number
        @lesson = Lesson.find_by lesson_number: (@prevlesson.lesson_number + 1)
        redirect_to lesson_path(id: @lesson.id)
      else
        redirect_to lessons_path
      end
    else
      redirect_to lesson_path(id: params[:l_id]), notice: "Something went wrong setting your lesson as complete, please try again."
    end

  end

end
