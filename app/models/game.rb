class Game < ApplicationRecord
<<<<<<< HEAD
    default_scope { order(title: :asc) }
    belongs_to :category
=======
  default_scope { order(title: :asc) }
  
  has_many :users, through: :favorites
  has_many :favorites

  has_one_attached :game_picture
  
>>>>>>> 019162873a4dee4bf9ff237c022438e31315f6e7
end
