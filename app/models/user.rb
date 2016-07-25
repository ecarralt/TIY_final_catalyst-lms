class User < ActiveRecord::Base
  validates :first_name, presence: true
  validates :last_name, presence: true

  validates :email, presence: true
  validates :username, presence: true

  has_secure_password

  has_many :lessons


  def full_name
      name = [self.first_name," ", self.last_name]
      name.join
  end
  
end
