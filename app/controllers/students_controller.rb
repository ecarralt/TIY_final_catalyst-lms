class StudentsController < ApplicationController

  layout :resolve_layout

  def index
    @students = User.all.where(usertype: "student").order(last_name: :asc)
    @lessons = Lesson.all.where(released: "1")
    @assignments = Assignment.all.where(released: "1")
  end

  def show
    @student = User.find_by(id: params[:id])
    @current_assignments = Assignment.all.where(released: "1").order(assignment_number: :asc)
    @current_lessons = Lesson.all.where(released:"1").order(lesson_number: :asc)
  end

end
