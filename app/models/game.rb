class Game < ApplicationRecord
    default_scope { order(title: :asc) }
end
