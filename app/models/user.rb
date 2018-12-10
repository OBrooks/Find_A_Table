class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :messages
  has_many :conversations, foreign_key: :sender_id
  
  enum status: {peasant: 1, admin: 2, webmaster: 3}
  has_and_belongs_to_many :sessions

  has_one_attached :profile_picture

  has_many :games, through: :favorites
  has_many :favorites

  after_create :send_mail_sign_in

  def send_mail_sign_in
    UserMailer.sign_in_mail(email, nickname).deliver_later
  end
end
