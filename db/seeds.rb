# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

City.destroy_all
User.destroy_all
Gossip.destroy_all
Tag.destroy_all
GoTag.destroy_all
PrivateMessage.destroy_all
PmUser.destroy_all
Comment.destroy_all

cities=[]
users=[]
gossips=[]
tags =[]
go_tags=[]
private_messages=[]
pm_users=[]
comments=[]

require 'faker'

20.times do
  city = City.create!(name: Faker::Address.city, zip_code: Faker::Address.zip_code)
  cities << city
end

50.times do
  user = User.create!(first_name: Faker::Name.first_name, last_name: Faker::Name.last_name, description: Faker::Lorem.sentence(word_count:5, supplemental: false, random_words_to_add: 5), email: Faker::Internet.email, age: rand(7..99), city: cities.sample, password_digest: Faker::Lorem.characters(number:6..15))
  users << user
end

100.times do
  gossip = Gossip.create!(title: Faker::Lorem.characters(number:3..14), content: Faker::Lorem.sentence(word_count:10, supplemental: true, random_words_to_add: 5), user: users.sample)
  gossips << gossip
end

10.times do
  tag = Tag.create!(title: Faker::Lorem.word)
  tags << tag
end

50.times do
  go_tag = GoTag.create!(tag: tags.sample, gossip: gossips.sample)
  go_tags << go_tag
end

100.times do
  private_message = PrivateMessage.create!(content: Faker::Lorem.sentence(word_count:10, supplemental: true, random_words_to_add: 5), sender: users.sample)
  private_messages << private_message
end

250.times do
  pm_user = PmUser.create!(recipient: users.sample, private_message: private_messages.sample)
  pm_users << pm_user
end

200.times do
  comment = Comment.create!(content: Faker::Lorem.sentence(word_count:5, supplemental: true, random_words_to_add: 5), user: users.sample, gossip: gossips.sample)
  comments << comment
end
