class Lesson < ActiveRecord::Base
  validates :title, presence: true
  validates :content, presence: true

  validates :author, presence: true
  validates :released, presence: true

  belongs_to :user

  def released_display
    if :released == 1
      return "Yes"
    else
      return "No"
    end
  end

end
