class Password < ApplicationRecord

  # see comment in user.rb file for the lines below. It will create a
  # through association and direct access to user in users.rb via user_password.rb
  has_many :user_passwords, dependent: :destroy
  has_many :users, through: :user_passwords

  # using the ActiveRecord encryption. keys are in /config/credentials
  encrypts :username, deterministic: true
  encrypts :password

  validates :url, presence: true
  validates :username, presence: true
  validates :password, presence: true

  def shareable_users
    User.excluding(users)
  end

  def editable_by?(user)
    user_passwords.find_by(user: user)&.editable?
  end

  def shareable_by?(user)
    user_passwords.find_by(user: user)&.shareable?
  end

  def deletable_by?(user)
    user_passwords.find_by(user: user)&.deletable?
  end
end
