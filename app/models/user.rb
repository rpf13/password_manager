class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

# relation to the user_passwords db and create link for passwords to be
# directly accessible, since we tell rails that the passwords are reached
# through the user_passwords table.
  has_many :user_passwords
  has_many :passwords, through: :user_passwords
end
