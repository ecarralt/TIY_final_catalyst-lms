class LessonsController < ApplicationController

  layout :resolve_layout

  def student_dashboard
    if @current_user.usertype == "student"
      @lessons = get_student_lessons
      @assignments = Assignment.all.where(released: "1").order(assignment_number: :asc)
    else
      @lessons = Lesson.all.order(lesson_number: :asc)
    end
  end

  def student_review
    if @current_user.usertype == "student"
      @lessons = get_completed_lessons_for_student
    else
      # @lessons = Lesson.all.order(lesson_number: :asc)
    end
  end

  def student_feedback
    if @current_user.usertype == "student"
      @assignments = get_submitted_assignments_for_student
    else
      # @lessons = Lesson.all.order(lesson_number: :asc)
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

  def get_completed_lessons_for_student
    @comp_lessons =[]
    @lessons_all = Lesson.all.where(released: "1").order(lesson_number: :asc)
    @lessons_all.each do |lesson|
      # 1) if there are no records for this lesson, do not add lesson to student lessons
      if lesson.lessonrecords == []
        #skip lesson
      else
        #2)for this lesson, if there is no record for this user, do not add lesson to student lessons
        if (lesson.lessonrecords.find_by(user_id: @current_user.id) == nil)
          #skip lesson
        else
          #also, if there are lesson records for this user/lesson, for all the records for this lesson...
          lesson.lessonrecords.each do |lrecord|
            #3) ...if the lesson record is for this user and is complete, then add lesson to student lessons
            if (lrecord.user_id == @current_user.id && lrecord.complete == "yes")
              @comp_lessons << lesson
            end
          end
        end
      end
    end
    return @comp_lessons
  end

  def get_submitted_assignments_for_student

    @subm_assignments =[]
    @assignments_all = Assignment.all.where(released: "1").order(lesson_number: :asc)
    @assignments_all.each do |assignment|
      # 1) if there are no records for this assignment, do not add assignment to student assingments
      if assignment.assignmentrecords == []
        #skip assignment
      else
        #2)for this assignment, if there is no record for this user/lesson, do not add lesson to student lessons
        if (assisgnment.assisgnmentrecords.find_by(user_id: @current_user.id) == nil)
          #skip assignment
        else
          #if there are assignment records for this user/lesson, then, for all the records for this lesson...
          assignment.assignmentrecords.each do |arecord|
            #3) ...if the assignment record is for this user and is complete, then add lesson to student lessons
            if (arecord.user_id == @current_user.id && arecord.complete == "yes")
              @comp_lessons << lesson
            end
          end
        end
      end
    end
    return @subm_assignments
  end

end
