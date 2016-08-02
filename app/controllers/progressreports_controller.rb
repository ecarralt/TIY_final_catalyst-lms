class ProgressreportsController < ApplicationController

  layout :resolve_layout


  def new
    @students = User.all.where(usertype: "student")
    # @this_pr_number =
    # @this_pr_title =
    # @this_total_lessons
    # @this_total_assignments
    # @this_lessons_completed =
    # @this_assignments_submitted =
  end

  def new2
    @pr = Progressreport.new

    @student = User.find_by(id: params[:student][:id])

    @pr.student_id = params[:student][:id]
    @this_pr_number = 1
    @this_pr_title = "Progress Report for @student.name"
    @this_total_lessons = Lesson.all.where(released: "1").count
    @this_total_assignments = Assignment.all.where(released: "1").count
    @this_lessons_completed = Lessonrecord.all.where(user_id: @student.id).count
    @this_assignments_submitted = Assignmentrecord.all.where(user_id: @student.id).count

  end


  def create

    @student = User.find_by(id: params[:st_id])

    @pr = Progressreport.new
    @pr.student_id = params[:st_id]

    @pr.title = params[:progressreport][:title]
    @pr.progress_score = params[:progressreport][:progress_score]
    @pr.instructor_feedback = params[:progressreport][:instructor_feedback]
    @pr.total_lessons = params[:progressreport][:total_lessons]
    @pr.completed_lessons = params[:progressreport][:completed_lessons]
    @pr.total_assignments = params[:progressreport][:total_assignments]
    @pr.completed_assignments = params[:progressreport][:completed_assignments]
    @pr.student_name = params[:progressreport][:student_name]
    @pr.user_id = params[:progressreport][:user_id]

    if @pr.save
      redirect_to students_path, notice: "Assignment submitted successfully"
    else
      flash[:notice] = "Your report was not created :(. Please fill out both your score and your feedback comments for this student."
      render :new2
    end

  end

  def show

  end


end
