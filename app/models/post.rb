# Entidade Post
class Post < ApplicationRecord
  belongs_to :user, optional: true

  validates :content, presence: true, length: { in: 1..140 }
  validates :user_id, presence: true
  validate :user_exists?

  private

  # Se um Post for associado a um User inexistente, levantara um erro
  def user_exists?
    errors.add(:user_id, " don't exists") unless User.exists?(user_id)
  end
end
