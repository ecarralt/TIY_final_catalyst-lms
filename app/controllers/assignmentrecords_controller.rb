class AssignmentrecordsController < ApplicationController
  layout :resolve_layout

  def grade
    @arecords = Assignmentrecord.all.where(score: nil)
  end

  def grade_arecord
    @arecord = Assignmentrecord.find_by id: params[:id]
  end
  def student_records

  end

end
