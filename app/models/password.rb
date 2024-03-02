class Password < ApplicationRecord

  # see comment in user.rb file for the lines below. It will create a
  # through association and direct access to user in users.rb via user_password.rb
  has_many :user_passwords
  has_many :users, through: :user_passwords

  # using the ActiveRecord encryption. keys are in /config/credentials
  encrypts :username, deterministic: true
  encrypts :password

  validates :url, presence: true
  validates :username, presence: true
  validates :password, presence: true
end
