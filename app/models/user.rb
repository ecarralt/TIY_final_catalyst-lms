class User < ActiveRecord::Base
  validates :first_name, presence: true
  validates :last_name, presence: true

  validates :email, presence: true, uniqueness: true
  validates :username, presence: true, uniqueness: true

  has_secure_password

  has_many :lessons
  has_many :assignments
  has_many :assignmentrecords
  has_many :lessonrecords
  has_many :progressreports


  def full_name
      name = [self.first_name," ", self.last_name]
      name.join
  end

end
