class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action do
    @current_user = User.find_by(id: session[:user_id])
  end

  def resolve_layout
    case @current_user.usertype
    when "student"
      "application"
    else
      "teachers"
    end
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
