class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  
  has_one_attached :profile_picture
  
  #status
  enum status: {unwanted: 0, peasant: 1, admin: 2, webmaster: 3}

  #User-to-user conversation
  has_many :messages
  has_many :conversations, foreign_key: :sender_id
  
  #Chatroom conversation
  has_many :chatroom_users
  has_many :chatrooms, through: :chatroom_users
  has_many :usersmessages

  #Sessions
  has_many :requests
  has_many :sessions, through: :requests

  #Favorites

    #Favorites games
  has_many :games, through: :favorites
  has_many :favorites

    #Favorites users
  has_many :adders, through: :favorites_users
  has_many :addeds, through: :favorites_users
  has_many :favorites_users

  #Comments' games
  has_many :gamecoms
  
  after_create :send_mail_sign_in

  def send_mail_sign_in
    UserMailer.sign_in_mail(email, nickname).deliver_later
  end
end
