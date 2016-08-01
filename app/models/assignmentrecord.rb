class Assignmentrecord < ActiveRecord::Base
  # validates :comments, presence: true, if: "contentfile.nil?", if: "url_link.nil?"

  attachment :contentfile, extension: ["pdf", "doc", "docx"]
  validate :at_least_one_submission_record

  belongs_to :user
  belongs_to :assignment

  def file_extension
    self.content_type.split("/").last.to_sym
  end

  def at_least_one_submission_record
    if (self.comments.present? == false && self.url_link.present? == false)
      return false
    else
      return true
    end
  end

end
