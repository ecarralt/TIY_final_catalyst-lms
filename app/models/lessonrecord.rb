class Lessonrecord < ActiveRecord::Base
  validates :complete, presence: true

  belongs_to :user
  belongs_to :lesson


end
