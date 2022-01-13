class User < ActiveRecord::Base
  has_secure_password

  before_save { self.email = email.downcase }
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, presence: true, uniqueness: true
  validates :password, presence: true, length: { minimum: 8 }, if: :password_digest_changed?

  def self.authenticate_with_credentials(email, password)
    user = User.find_by_email(email)

    # If the user exists AND the password entered is correct.
    if user && user.authenticate(password)
        return user
    else
        return nil
    end
  end
end
