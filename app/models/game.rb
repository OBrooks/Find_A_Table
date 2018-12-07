class Game < ApplicationRecord
  default_scope { order(title: :asc) }
  
  has_many :users, through: :favorites
  has_many :favorites

  has_one_attached :game_picture
  
end
