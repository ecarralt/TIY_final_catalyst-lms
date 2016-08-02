class Progressreport< ActiveRecord::Base
  validates :title, presence: true
  validates :progress_score, presence: true
  validates :instructor_feedback, presence: true

  validates :total_lessons, presence: true
  validates :total_assignments, presence: true

  validates :completed_lessons, presence: true
  validates :completed_assignments, presence: true

  validates :student_id, presence: true
  validates :student_name, presence: true

  belongs_to :user

end
