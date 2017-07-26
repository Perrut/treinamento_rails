class Post < ApplicationRecord

  belongs_to :user, optional: true

  validates :content, presence: true, length: { in: 1..140 }
  validates :user_id, presence: true
  validate :user_exists?

  def user_exists?
    if !User.exists?(self.user_id)
      errors.add(:user_id, " don't exists")
    end
  end

end
