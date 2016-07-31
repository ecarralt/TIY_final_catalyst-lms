class LessonrecordsController < ApplicationController

  layout :resolve_layout

  def create
    #case 1: complete lesson record does not exit for this lesson/user
    if Lessonrecord.find_by(user_id: params[:u_id], lesson_id: params[:l_id]) == nil
      @lrecord = Lessonrecord.new
      @lrecord.complete = "yes"
      @lrecord.lesson_id = params[:l_id]
      @lrecord.user_id = params[:u_id]
      if @lrecord.save
        redirection_to_next_lesson
      else
        redirect_to lesson_path(id: params[:l_id]), notice: "Something went wrong setting your lesson as complete, please try again."
      end
    #case 2: complete lesson record exists for this lesson/user, and the student has not completed the lesson
    elsif @lrecord = Lessonrecord.find_by(user_id: params[:u_id], lesson_id: params[:l_id], complete: "no")
      @lrecord.complete ="yes"
      if @lrecord.save
        redirection_to_next_lesson
      else
        redirect_to lesson_path(id: params[:l_id]), notice: "Something went wrong setting your lesson as complete, please try again."
      end
    #case 3: complete lesson record exists for this lesson/user, and the student has already completed the lesson  
    elsif @lrecord = Lessonrecord.find_by(user_id: params[:u_id], lesson_id: params[:l_id], complete: "yes")
      redirection_to_next_lesson
    end
  end

  def redirection_to_next_lesson
    #Preparing redirection to next lesson
    @prevlesson = Lesson.find_by id: params[:l_id]
    max_lesson_number = Lesson.maximum("lesson_number")

    if @prevlesson.lesson_number < max_lesson_number
      @lesson = Lesson.find_by lesson_number: (@prevlesson.lesson_number + 1)
      redirect_to lesson_path(id: @lesson.id)
    else
      redirect_to lessons_path
    end
  end

end
