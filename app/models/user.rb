class User < ActiveRecord::Base
  validates :first_name, presence: true
  validates :last_name, presence: true

  validates :email, presence: true
  validates :username, presence: true

  has_secure_password

  has_many :lessons

end
