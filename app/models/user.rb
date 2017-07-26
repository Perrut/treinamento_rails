class User < ApplicationRecord

  has_many :posts, dependent: :destroy

  validates :name, presence: true, length: { in: 2..50 }
  validates :email, presence: true, length: { minimum: 10, maximum: 60 }
  validates :address, presence: true, length: { minimum: 10, maximum: 100 }

end
