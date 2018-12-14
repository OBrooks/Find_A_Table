class Game < ApplicationRecord
  default_scope { order(title: :asc) }
  belongs_to :category

  
  has_many :favorites
  has_many :users, through: :favorites

  has_one_attached :game_picture

  has_many :gamecoms

end
