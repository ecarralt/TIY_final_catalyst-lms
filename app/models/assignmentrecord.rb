class Assignmentrecord < ActiveRecord::Base
  validates :comments, presence: true

  belongs_to :user

end
