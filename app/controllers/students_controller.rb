class StudentsController < ApplicationController

  layout :resolve_layout

  def index
    @students = User.all.where(usertype: "student").order(last_name: :asc)
    @lessons = Lesson.all.where(released: "1").order(lesson_number: :asc)
    @assignments = Assignment.all.where(released: "1").order(assignment_number: :asc)

    @subm_assignment_count = get_submitted_arecords_for_student.count

  end

  def show
    @student = User.find_by(id: params[:id])
    @current_assignments = Assignment.all.where(released: "1").order(assignment_number: :asc)
    @current_lessons = Lesson.all.where(released:"1").order(lesson_number: :asc)
  end

  def get_submitted_arecords_for_student
    @subm_arecords =[]
    @assignments_all = Assignment.all.where(released: "1").order(assignment_number: :asc)
    @assignments_all.each do |assignment|
      # 1) if there are no records for this assignment, do not add assignment to student assingments
      #2)for this assignment, if there is no record for this user, do not add assignment to student lessons

      if assignment.assignmentrecords.find_by(user_id: 1) == nil
          #skip assignment
      else
            ##grab all arecords for this user and lesson, pick the latest one, and add it to the list
            all_user_arecords = assignment.assignmentrecords.order(created_at: :asc).select{|record| record.user_id == 1}
            if all_user_arecords != nil
              # && all_user_arecords.last.score != nil
              @subm_arecords << all_user_arecords.last
            end
      end
    end
    return @subm_arecords
  end


end
