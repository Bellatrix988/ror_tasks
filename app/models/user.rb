class User < ApplicationRecord

  validates :name, presence: true, length: { maximum: 50 }
  validates :email, presence: true, length: { maximum: 50 }
  validates :password, presence: true, length: { minimum: 3 }

end
