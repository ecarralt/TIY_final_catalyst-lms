class Assignmentrecord < ActiveRecord::Base
  validates :comments, presence: true
  attachment :contentfile, extension: ["pdf", "doc", "docx"]

  belongs_to :user
  belongs_to :assignment

  def file_extension
    self.content_type.split("/").last.to_sym
  end

end
