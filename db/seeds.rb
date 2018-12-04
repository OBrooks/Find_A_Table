# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

user=User.create!(email: "thpbordeaux@gmail.com", password: "123456")

user=User.create!(email: "nazicat@nazi.cat", password: "nazicat")

5.times do
  game=Game.create!(title: Faker::Community.characters, description: Faker::FamousLastWords.last_words, min_players: Random.rand(1..3), max_players: Random.rand(3..10))
end
