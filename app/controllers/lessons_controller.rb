class LessonsController < ApplicationController

  layout :resolve_layout

  def student_dashboard
    if @current_user.usertype == "student"
      @lessons = get_student_incomplete_lessons
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
      @arecords = get_submitted_arecords_for_student
      @prs = get_prs_for_student
    else
      # @lessons = Lesson.all.order(lesson_number: :asc)
    end
  end

  def show
    @lesson = Lesson.find_by id: params[:id]
    @current_l_number = @lesson.lesson_number
    @max_lesson_number = Lesson.maximum("lesson_number")
    @next_lesson = Lesson.find_by lesson_number: (@current_l_number+1)
    student_lrecord = @lesson.lessonrecords.find_by(user_id: @current_user.id)
    if student_lrecord == nil || student_lrecord.complete == "no"
    @lesson_type = "incomplete"
    elsif student_lrecord.complete == "yes"
      @lesson_type = "completed"
    end
    # @last_lesson_number = Lesson.maximum("lesson_number")
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

  def get_student_incomplete_lessons
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

  def get_submitted_arecords_for_student
    @subm_arecords =[]
    @assignments_all = Assignment.all.where(released: "1").order(assignment_number: :asc)
    @assignments_all.each do |assignment|
      # 1) if there are no records for this assignment, do not add assignment to student assingments
      if assignment.assignmentrecords == []
        #skip assignment

        #2)for this assignment, if there is no record for this user, do not add assignment to student lessons
      elsif (assignment.assignmentrecords.find_by(user_id: @current_user.id) == nil)
          #skip assignment
      else
            ##grab all arecords for this user and lesson, pick the latest one, and add it to the list
            all_user_arecords = assignment.assignmentrecords.order(created_at: :asc).select{|record| record.user_id==@current_user.id && record.assignment_id==assignment.id}
            if all_user_arecords != nil && all_user_arecords.last.score != nil
              @subm_arecords << all_user_arecords.last
            end
      end
    end
    return @subm_arecords
  end

  def get_prs_for_student
    prs = Progressreport.all.where(student_id: @current_user.id).order(pr_number: :asc)
    return prs
  end

end
