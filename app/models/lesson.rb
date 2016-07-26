class Lesson < ActiveRecord::Base
  validates :title, presence: true
  validates :content, presence: true

  validates :author, presence: true
  validates :released, presence: true

  belongs_to :user
  
end
