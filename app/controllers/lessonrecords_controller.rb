class LessonrecordsController < ApplicationController

  layout :resolve_layout

  before_action do
    @lessons_all = Lesson.all.where(released: "1").order(lesson_number: :asc)
    @inc_lessons = get_student_incomplete_lessons
    @comp_lessons = get_student_completed_lessons
    @prevlesson = Lesson.find_by(id: params[:l_id])
    if @prevlesson.lessonrecords.find_by(user_id: @current_user.id, complete: "yes")
      @prevlesson_type = "completed"
    else
      @prevlesson_type = "incomplete"
    end
  end

  def create
    next_lesson_inc_index = get_next_lesson_inc_index
    next_lesson_comp_index = get_next_lesson_comp_index
    next_lesson_all_index = get_next_lesson_all_index
    #case 1: complete lesson record does not exist for this lesson/user
    if Lessonrecord.find_by(user_id: params[:u_id], lesson_id: params[:l_id]) == nil
      @lrecord = Lessonrecord.new
      @lrecord.complete = "yes"
      @lrecord.lesson_id = params[:l_id]
      @lrecord.user_id = params[:u_id]
      if @lrecord.save
        redirection_to_next_lesson(next_lesson_inc_index, next_lesson_comp_index, next_lesson_all_index)
      else
        redirect_to lesson_path(id: params[:l_id]), notice: "Something went wrong setting your lesson as complete, please try again."
      end
    #case 2: complete lesson record exists for this lesson/user, and the student has not completed the lesson
    elsif @lrecord = Lessonrecord.find_by(user_id: params[:u_id], lesson_id: params[:l_id])
      @lrecord.complete ="yes"
      if @lrecord.save
        redirection_to_next_lesson(next_lesson_inc_index, next_lesson_comp_index, next_lesson_all_index)
      else
        redirect_to lesson_path(id: params[:l_id]), notice: "Something went wrong setting your lesson as complete, please try again."
      end
    #case 3: complete lesson record exists for this lesson/user, and the student has already completed the lesson
    elsif @lrecord = Lessonrecord.find_by(user_id: params[:u_id], lesson_id: params[:l_id], complete: "yes")
      redirection_to_next_lesson(next_lesson_inc_index, next_lesson_comp_index, next_lesson_all_index)
    end
  end

  def update
      @lrecord = Lessonrecord.find_by(user_id: params[:u_id], lesson_id: params[:l_id])
      @lrecord.complete = "no"
      if @lrecord.save
        redirect_to lesson_path(id: params[:l_id]), notice: "This lesson has now been added back to your dashboard."
      else
        redirect_to lesson_path(id: params[:l_id]), notice: "Something went wrong putting your lesson back on your dashboard, please try again."
      end
  end

  def redirection_to_next_lesson(next_inc_index, next_comp_index, next_all_index)
    #Preparing redirection to next lesson
    #1) get the lesson the stuedent is moving from
      # @prevlesson = Lesson.find_by id: params[:l_id]
    #2) get the max number of lessons, in general
      max_lesson_number = Lesson.where(released: "1").maximum("lesson_number")
    #3) get max lesson number, for lessons that this student has not completed
      # @inc_lessons = get_student_incomplete_lessons
    #4) get max lesson number, for lessons that this student has completed

    #Logic on cases for redirection starts here
    if @prevlesson_type == "completed"
      #follow some complete lessson path
      max_lesson_number_comp = get_max_lesson_number_complete
      #if last within complete, redirect to review
      if @prevlesson.lesson_number == max_lesson_number_comp
        redirect_to student_review_path, notice: "That was the last lesson in your review list, good job!"
      else
        #if not last, then redirecto next within complete
        next_comp_index = (next_comp_index + 1)
        @nextlesson_comp = @comp_lessons[next_comp_index]
        redirect_to lesson_path(id: @nextlesson_comp.id)
      end

    elsif @prevlesson_type == "incomplete"
      #follow some incomplete lesson path
      max_lesson_number_inc = get_max_lesson_number_inc
      #1) Check if no records exist for the student (start case)
      if (Lessonrecord.find_by(user_id: @current_user.id) == nil || @inc_lessons == [] || @inc_lessons == nil)
        #if lesson is the last one within released, redirect to db
        if @prevlesson.lesson_number == max_lesson_number
          redirect_to lessons_path
        else
          #redirect to next released lesson
          ##this needs the group of released lessons, not just lesson_number + 1 (that can lead to nil)
          # @nextlesson = Lesson.where(released: "1").find_by lesson_number: (@prevlesson.lesson_number + 1)
          # redirect_to lesson_path(id: @nextlesson.id)

          #redirect to next released lesson
          next_all_index = (next_all_index + 1)
          @nextlesson_all = @lessons_all[next_all_index]
          redirect_to lesson_path(id: @nextlesson_all.id)
        end

      else
        #2) if there are records, if the lesson is the last within incomplete,
        #then go back to DB
        if @prevlesson.lesson_number == max_lesson_number_inc
          redirect_to lessons_path
        else
          #if there are records and not the last within incomplete, go next within
          #incomplete
          next_inc_index = (next_inc_index + 1)
          @nextlesson_inc = @inc_lessons[next_inc_index]
          redirect_to lesson_path(id: @nextlesson_inc.id)
        end
      end
    end
  end


###---------------------------- copy methods from here on --------------
    #
    # #1) Check if no records exist for the student (start case)
    # if (Lessonrecord.find_by(user_id: @current_user.id) == nil || @inc_lessons == [] || @inc_lessons == nil)
    #   #if lesson is the last one within released, redirect to db
    #   if @prevlesson.lesson_number == max_lesson_number
    #     redirect_to lessons_path
    #   else
    #     #redirect to next released lesson
    #     ##this needs the group of released lessons, not just lesson_number + 1 (that can lead to nil)
    #     @nextlesson = Lesson.where(released: "1").find_by lesson_number: (@prevlesson.lesson_number + 1)
    #     redirect_to lesson_path(id: @nextlesson.id)
    #   end
    #
    # else
    #   #2) if there are records, if the lesson is the last within incomplete, then go back to DB
    #   if @prevlesson.lesson_number == max_lesson_number_inc
    #     redirect_to lessons_path
    #   #3) if there are records, if the lessson is the last within complete,
    #   #then go back to Review
    #   elsif @prevlesson.lesson_number == max_lesson_number_comp
    #     redirect_to student_review_path
    #
    #   #4) if not the the last lesson within incomplete/complete,
    #   #go to the next incomplete / complete
    #   #4a) if lesson has been completed, redirect to next completed lesson
    #   elsif @prevlesson.lessonrecords.find_by(user_id: @current_user.id).complete == "yes"
    #     next_comp_index = (next_comp_index + 1)
    #     @nextlesson_comp = @comp_lessons[next_comp_index]
    #     redirect_to lesson_path(id: @nextlesson_comp.id)
    #   #4b) if lesson has not been completed, redirect to next incomplete lesson
    #   elsif @prevlesson.lessonrecords.find_by(user_id: @current_user.id).complete == "no"
    #     next_inc_index = (next_inc_index + 1)
    #     @nextlesson_inc = @inc_lessons[next_inc_index]
    #     redirect_to lesson_path(id: @nextlesson_inc.id)
    #   end
    #
    # end


  def get_student_incomplete_lessons
    @s_lessons = []
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

  def get_student_completed_lessons
    @s_lessons = []
    @lessons_all.each do |lesson|
        lesson.lessonrecords.each do |lrecord|
          #3) if the lesson record is for this user and is not complete, then add it to student lessons
          if (lrecord.user_id == @current_user.id && lrecord.complete == "yes")
            @s_lessons << lesson
          end
        end
    end
    return @s_lessons
  end

  def get_next_lesson_inc_index
    #identify index position of prev lesson within incomplete lessons

    if (@inc_lessons == [] || @inc_lessons == nil)
      @lessons = Lesson.where(released: "1").order(lesson_number: :asc)
      index_position = @lessons.find_index{|l| l.lesson_number == @prevlesson.lesson_number}

    else
      index_position = @inc_lessons.find_index{|l| l.lesson_number == @prevlesson.lesson_number}
      # next_index_position = prev_index_position + 1
    end
    return index_position
  end
  def get_next_lesson_comp_index
    index_position = @comp_lessons.find_index{|l| l.lesson_number == @prevlesson.lesson_number}
    return index_position
  end

  def get_next_lesson_all_index
    index_position = @lessons_all.find_index{|l| l.lesson_number == @prevlesson.lesson_number}
    return index_position
  end

  def get_max_lesson_number_inc
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
    return max_lesson_number_inc
  end

  def get_max_lesson_number_complete
    if @comp_lessons == []
      max_lesson_number_comp = @prevlesson.lesson_number
    else
      @lesson_numbers_comp = [] ##find this below
      @comp_lessons.each do |l|
        @lesson_numbers_comp << l.lesson_number
      end
      ##set max
      max_lesson_number_comp = @lesson_numbers_comp.max
    end
    return max_lesson_number_comp
  end


end
