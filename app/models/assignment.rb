class Assignment < ActiveRecord::Base
  validates :title, presence: true
  validates :content, presence: true

  validates :author, presence: true
  validates :released, presence: true
  validates :assignment_number, numericality: {only_integer: true}

  belongs_to :user
  has_many :assignmentrecords

  def released_display
    if self.released == "1"
      return "Yes"
    elsif self.released == "0"
      return "No"
    end
  end

  def release_true?
    if self.released == "1"
      return true
    else
      return false
    end
  end

  def release_false?
    if self.released == "0"
      return true
    else
      return false
    end
  end

end
