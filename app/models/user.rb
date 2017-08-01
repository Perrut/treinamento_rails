# Entidade Usuario
class User < ApplicationRecord
  before_save :downcase_email

  has_many :posts, dependent: :destroy

  has_secure_password

  validates :name, presence: true, length: { in: 2..50 }
  validates :email,
            presence: true,
            length: { minimum: 10, maximum: 60 },
            uniqueness: true
  validates :address, presence: true, length: { minimum: 10, maximum: 100 }
  validates :password, presence: true, length: { in: 6..20 }, allow_nil: true

  private

  # Salva os emails com letras minusculas, para evitar problemas
  def downcase_email
    self.email = email.downcase
  end
end
