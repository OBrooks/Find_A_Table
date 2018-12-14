class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_one_attached :profile_picture

  #status
  enum status: {unwanted: 0, peasant: 1, admin: 2, webmaster: 3}

  #User-to-user conversation
  has_many :messages, dependent: :destroy
  has_many :conversations, foreign_key: :sender_id, dependent: :destroy

  #Chatroom conversation
  has_many :chatroom_users, dependent: :destroy
  has_many :chatrooms, through: :chatroom_users, dependent: :destroy
  has_many :usersmessages, dependent: :destroy

  #Sessions
  has_many :requests
  has_many :sessions, through: :requests

  #Favorites

  has_many :favorites
  has_many :games, through: :favorites

  #Favorites users
  has_many :favorites_users
  has_many :adders, through: :favorites_users
  has_many :addeds, through: :favorites_users

  #Comments' games
  has_many :gamecoms

  # validates_presence_of :nickname, uniqueness: true, on: :create
  # validates_presence_of :birthdate, on: :create
  # validates_presence_of :gender, on: :create
  # validates_presence_of :town, on: :create
  # validates_presence_of :first_name, on: :create
  # validates_presence_of :last_name, on: :create

  has_many :notifications, foreign_key: :recipient_id

  after_create :send_mail_sign_in

  def send_mail_sign_in
    UserMailer.sign_in_mail(email, nickname).deliver_later
  end
end
