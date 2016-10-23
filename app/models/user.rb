class User < ApplicationRecord
  validates :first_name, :last_name, presence: true
  validates :password,
            presence: true,
            confirmation: true,
            unless: Proc.new { |a| a.password.blank? },
            length: { minimum: 6 }
  validates :password_confirmation, presence: true

  validates :email,
            uniqueness: true,
            presence: true,
            length: { maximum: 255 },
            format: { with: VALID_EMAIL }

  has_secure_password

  def full_name
    "#{first_name.capitalize} #{last_name.capitalize}"
  end
end
