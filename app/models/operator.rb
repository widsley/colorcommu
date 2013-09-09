class Operator < ActiveRecord::Base
  has_secure_password

  paginates_per 10

  before_create { generate_token(:auth_token) }

  def send_password_reset
    generate_token(:password_reset_token)
    self.password_reset_sent_at = Time.zone.now
    save!
    OperatorMailer.password_reset(self).deliver
  end

  def generate_token(column)
    begin
      self[column] = SecureRandom.urlsafe_base64
    end while Operator.exists?(column => self[column])
  end

  validates :username,
            presence: true,
            length: {maximum: 255},
            format: {with: /\A[-A-Za-z0-9_]+\z/},
            uniqueness: true
  validates :email,
            presence: true,
            format: {with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i},
            length: { maximum: 255 },
            uniqueness: true
  validates :password,
            confirmation: {if: :password_digest_changed?},
            presence: {on: :create},
            format: {with: /\A[-A-Za-z0-9_]+\z/, allow_blank: true}
end
