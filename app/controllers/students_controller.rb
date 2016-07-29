class StudentsController < ApplicationController

@lessons =

def index
  @students = User.all.where(usertype: "student").order(last_name: :asc)
  # @completed_lessons = get_completed_lessons
  # @submited_assingments = get_submitted_assignments
  @lessons = Lesson.all.where(released: "1")
  @assignments = Assignment.all.where(released: "1")
end

def get_completed_lessons



end


end
