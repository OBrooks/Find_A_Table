class Game < ApplicationRecord
    default_scope { order(title: :asc) }
    belongs_to :category
end
