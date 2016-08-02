class ProgressreportsController < ApplicationController

  layout :resolve_layout


  def new
    @students = User.all.where(usertype: "student")
  end

  def new2

    if params[:student][:id] == ""
      flash[:notice] = "Please select a student."
      @students = User.all.where(usertype: "student")
      render :new
    else
      @pr = Progressreport.new

      @student = User.find_by(id: params[:student][:id])

      @pr.student_id = params[:student][:id]
      @this_pr_number = get_pr_number
      @this_pr_title = "Progress Report ##{@this_pr_number} for #{@student.full_name}"
      @this_total_lessons = Lesson.all.where(released: "1").count
      @this_total_assignments = Assignment.all.where(released: "1").count
      @this_lessons_completed = Lessonrecord.all.where(user_id: @student.id).count
      @this_assignments_submitted = Assignmentrecord.all.where(user_id: @student.id).count
    end
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
    @pr.pr_number = params[:progressreport][:pr_number]
    @pr.user_id = params[:progressreport][:user_id]

    if @pr.save
      redirect_to students_path, notice: "Progress report created successfully"
    else
      flash[:notice] = "Your report was not created :(. Please fill out both your score and your feedback comments for this student."

      render :new2
    end

  end

  def show

  end

  def get_pr_number
      @student = User.find_by(id: params[:student][:id])
      pr = Progressreport.all.where(student_id: @student.id).order(pr_number: :asc).last
      if pr == nil
        pr_no = 1
      else
        pr_no = pr.pr_number + 1
      end

      return pr_no
  end


end
