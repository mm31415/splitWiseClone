class User < ApplicationRecord
  validates :email, presence: true, uniqueness: true
  validates :name, presence: true
  validates :password, length: { minimum: 6, allow_nil: true }

  attr_reader :password

  has_many(
    :friendships,
    class_name: "Friendship",
    foreign_key: :user1_id,
    primary_key: :id,
    dependent: :destroy
  )

  has_many(
    :pair_friendships,
    class_name: "Friendship",
    foreign_key: :user2_id,
    primary_key: :id,
    dependent: :destroy
  )

  has_many(
    :friends,
    through: :friendships,
    source: :friend
  )

  has_many(
    :splits,
    class_name: "BillSplit",
    foreign_key: :user_id,
    primary_key: :id
  )

  has_many(
    :bills,
    through: :splits,
    source: :bill,
    dependent: :destroy
  )

  has_many(
    :payer_payments,
    through: :friendships,
    source: :payments
  )

  has_many(
    :payee_payments,
    through: :pair_friendships,
    source: :payments
  )

  after_initialize :ensure_session_token!

  def User.find_by_credentials(email, password)
    user = User.find_by(email: email)
    return user if user && user.is_password?(password)
  end

  def User.generate_session_token!
    SecureRandom.urlsafe_base64(16)
  end

  def reset_session_token!
    self.session_token = User.generate_session_token!
    self.save
    self.session_token
  end

  def is_password?(password)
    BCrypt::Password.new(password_digest).is_password?(password)
  end

  def password=(password)
    @password = password
    self.password_digest = BCrypt::Password.create(password)
  end

  def ensure_session_token!
    self.session_token ||= User.generate_session_token!
  end
end
