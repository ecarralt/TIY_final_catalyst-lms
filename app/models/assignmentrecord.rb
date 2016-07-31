class Assignmentrecord < ActiveRecord::Base

  validates :comments, presence: true, if: "contentfile.nil?", if: "url_link.nil?"

  attachment :contentfile, extension: ["pdf", "doc", "docx"]

  belongs_to :user
  belongs_to :assignment

  def file_extension
    self.content_type.split("/").last.to_sym
  end

end
