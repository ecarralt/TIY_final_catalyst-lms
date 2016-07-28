class Assignmentrecord < ActiveRecord::Base
  validates :comments, presence: true
  attachment :contentfile, extension: ["pdf", "doc", "docx"]

  belongs_to :user

end
