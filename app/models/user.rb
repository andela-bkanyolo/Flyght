class User < ApplicationRecord
  validates :first_name, :last_name, presence: true
  validates :password,
            presence: true,
            confirmation: true,
            length: { minimum: 6 }
  validates :password_confirmation, presence: true
  validates :email,
            uniqueness: true,
            presence: true,
            length: { maximum: 255 },
            format: { with: VALID_EMAIL }
  has_many :bookings

  has_secure_password

  def full_name
    "#{first_name.capitalize} #{last_name.capitalize}"
  end

  def self.default_user
    User.find_by(email: 'default@flyght.com') ||
      User.create(first_name: 'Default',
                  last_name: 'Default',
                  email: 'default@flyght.com',
                  password: ENV['default_user_password'],
                  password_confirmation: ENV['default_user_password'])
  end
end
