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


  end

  def show

  end


end
