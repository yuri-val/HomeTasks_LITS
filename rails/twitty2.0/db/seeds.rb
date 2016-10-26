# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
User.destroy_all
Twit.destroy_all
Comment.destroy_all
Tag.destroy_all

10.times do
    Tag.create(name: Faker::Hipster.word)
end

5.times do
    name = Faker::Internet.user_name
    u = User.create(nickname: name,
                    email: Faker::Internet.email(name),
                    avatar: "https://robohash.org/#{name}.jpg")
    5.times do
        tw = Twit.create(content: Faker::Lorem.sentence(10, false, 0).chop,
                         user_id: u.id)
        3.times do
            com = Comment.create(user_id: tw.id,
                                 body:    Faker::Lorem.sentence(5, false, 0).chop,
                                 twit_id: tw.user.id)
        end
    end
end
