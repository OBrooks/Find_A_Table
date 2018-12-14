class Session < ApplicationRecord

  belongs_to :host, class_name: "User"
  belongs_to :game

  has_many :likes_to_users

  enum status: {available: 0, full: 1, done: 2, cancelled: 3}
  enum playerskill: {anylevel: 0, noob: 1, veteran: 2, expert: 3}
  validates :date, presence: true
  validates :city, presence: true
  validates :adress, presence: true
  validates :maxplayers, presence: true
  validates :playernb, presence: true
  validates :time, presence: true
  has_many :requests
  has_many :players, class_name: "User", through: :requests, source: :user
end
