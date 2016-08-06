class User < ActiveRecord::Base
  validates :first_name, presence: true
  validates :last_name, presence: true

  validates :email, presence: true, uniqueness: true
  validates :username, presence: true, uniqueness: true

  has_secure_password

  has_many :lessons #teacher
  has_many :assignments #teacher
  has_many :assignmentrecords #student
  has_many :lessonrecords #student
  has_many :progressreports #teacher


  def full_name
      name = [self.first_name," ", self.last_name]
      name.join
  end

end
