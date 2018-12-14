class LikesToUser < ApplicationRecord
  belongs_to :liker, :class_name => "User"
  belongs_to :liked, :class_name => "User"
  belongs_to :session
end
