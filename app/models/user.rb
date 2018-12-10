class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :messages
  has_many :conversations, foreign_key: :sender_id
  
  enum status: {peasant: 1, admin: 2, webmaster: 3}

  has_one_attached :profile_picture
<<<<<<< HEAD
=======

  has_many :games, through: :favorites
  has_many :favorites

>>>>>>> 019162873a4dee4bf9ff237c022438e31315f6e7
end
