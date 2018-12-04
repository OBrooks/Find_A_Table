class Session < ApplicationRecord
  belongs_to :host, class_name: "User"
  belongs_to :game
  enum status: {available: 0, full: 1, done: 2, cancelled: 3}
  enum playerskill: {any: 0, noob: 1, veteran: 2, expert: 3}
end
