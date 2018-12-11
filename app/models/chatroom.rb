class Chatroom < ApplicationRecord
  belongs_to :session
  has_many :chatroom_users
  has_many :users, through: :chatroom_users
  has_many :usersmessages
end
