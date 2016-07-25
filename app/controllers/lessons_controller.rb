class LessonsController < ApplicationController

  def dashboard
    @lessons = Lesson.all
  end

end
