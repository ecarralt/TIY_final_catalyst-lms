class LessonrecordsController < ApplicationController

  layout :resolve_layout

  def create
    #case 1: complete lesson record does not exist for this lesson/user
    if Lessonrecord.find_by(user_id: params[:u_id], lesson_id: params[:l_id]) == nil
      next_lesson_index = get_next_lesson_index
      @lrecord = Lessonrecord.new
      @lrecord.complete = "yes"
      @lrecord.lesson_id = params[:l_id]
      @lrecord.user_id = params[:u_id]
      if @lrecord.save
        redirection_to_next_lesson(next_lesson_index)
      else
        redirect_to lesson_path(id: params[:l_id]), notice: "Something went wrong setting your lesson as complete, please try again."
      end
    #case 2: complete lesson record exists for this lesson/user, and the student has not completed the lesson
    else @lrecord = Lessonrecord.find_by(user_id: params[:u_id], lesson_id: params[:l_id])
      @lrecord.complete ="yes"
      if @lrecord.save
        redirection_to_next_lesson(next_lesson_index)
      else
        redirect_to lesson_path(id: params[:l_id]), notice: "Something went wrong setting your lesson as complete, please try again."
      end
    # #case 3: complete lesson record exists for this lesson/user, and the student has already completed the lesson
    # elsif @lrecord = Lessonrecord.find_by(user_id: params[:u_id], lesson_id: params[:l_id], complete: "yes")
    #   redirection_to_next_lesson
    end
  end

  def update
      @lrecord = Lessonrecord.find_by(user_id: params[:u_id], lesson_id: params[:l_id]) == nil
      @lrecord.complete = "no"
      if @lrecord.save
        redirection_to_next_lesson
      else
        redirect_to lesson_path(id: params[:l_id]), notice: "Something went wrong putting your lesson on your dashboard, please try again."
      end
  end

  def redirection_to_next_lesson(next_inc_index)
    #Preparing redirection to next lesson
    #1) get the lesson the stuedent is moving from
      # @prevlesson = Lesson.find_by id: params[:l_id]
    #2) get the max number of lessons, in general
      max_lesson_number = Lesson.maximum("lesson_number")
    #3) get max lesson number, for lessons that this student has not completed
      # @inc_lessons = get_student_incomplete_lessons

      if @inc_lessons == []
        max_lesson_number_inc = @prevlesson.lesson_number
      else
        @lesson_numbers_inc = [] ##find this below

        @inc_lessons.each do |l|
          @lesson_numbers_inc << l.lesson_number
        end
        ##set max
        max_lesson_number_inc = @lesson_numbers_inc.max
      end

    #Logic on cases for redirection starts here
    #1) Check if no records exist for the student
    if Lessonrecord.find_by user_id: @current_user.id == nil
      if @prevlesson.lesson_number == max_lesson_number
        redirect_to lessons_path
      else
        ##this needs the group of released lessons, not just lesson_number + 1 (that can lead to nil)
        @nextlesson = Lesson.where(released: "1").find_by lesson_number: (@prevlesson.lesson_number + 1)
        redirect_to lesson_path(id: @nextlesson.id)
      end

    else
      #2) if the lesson is the last within incomplete, then go back to DB
      if @prevlesson.lesson_number == max_lesson_number_inc
        redirect_to lessons_path
      else #3) if not the the last lesson within incomplete, go to the next incomplete
        next_inc_index = (next_inc_index + 1)
        @nextlesson_inc = @inc_lessons[next_inc_index]

        redirect_to lesson_path(id: @nextlesson_inc.id)
      end
    end
  end


  def get_student_incomplete_lessons
    @s_lessons = []
    @lessons_all = Lesson.all.where(released: "1").order(lesson_number: :asc)
    @lessons_all.each do |lesson|
      # 1) if there are no records for this lesson, add them all to student lessons
      if lesson.lessonrecords == []
        @s_lessons << lesson

      #2)for this lesson, if there is no record for this user, add it to student lessons
      elsif (lesson.lessonrecords.find_by(user_id: @current_user.id) == nil)
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
    return @s_lessons
  end

  def get_next_lesson_index
    #identify index position of prev lesson within incomplete lessons
    @inc_lessons = get_student_incomplete_lessons
    @prevlesson = Lesson.find_by(id: params[:l_id])
    if @inc_lessons == []
      @lessons = Lesson.where(released: "1").order(lesson_number: :asc)
      index_position = @lessons.find_index{|l| l.lesson_number == @prevlesson.lesson_number}

    else
      index_position = @inc_lessons.find_index{|l| l.lesson_number == @prevlesson.lesson_number}
      # next_index_position = prev_index_position + 1
    end
    return index_position
  end
end
