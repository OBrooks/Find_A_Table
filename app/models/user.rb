class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
<<<<<<< HEAD

  has_many :conversations, :foreign_key => :sender_id
=======
  
  enum status: {peasant: 1, admin: 2, webmaster: 3}
>>>>>>> paul
end
