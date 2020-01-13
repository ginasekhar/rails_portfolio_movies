# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Movie.destroy_all

Movie.create!([{
  title: "Bad Boys for Life",
  description: "The Bad Boys Mike Lowrey and Marcus Burnett are back together for one last ride in the highly anticipated Bad Boys for Life.",
  genre: "Action",
  release_date: "20200117"
  rating: "R"
},
{
    title: "Frozen 2",
    description: "Anna, Elsa, Kristoff, Olaf and Sven leave Arendelle to travel to an ancient, autumn-bound forest of an enchanted land. They set out to find the origin of Elsa's powers in order to save their kingdom.",
    genre: "Animation",
    release_date: "20191122"
    rating: "G"
  },
  {
    title: "Spies In Disguise",
    description: "When the world's best spy is turned into a pigeon, he must rely on his nerdy tech officer to save the world.",
    genre: "Animation",
    release_date: "20191225"
    rating: "PG"
  }
  {
    title: "Frozen 2",
    description: "Anna, Elsa, Kristoff, Olaf and Sven leave Arendelle to travel to an ancient, autumn-bound forest of an enchanted land. They set out to find the origin of Elsa's powers in order to save their kingdom.",
    genre: "Animation",
    release_date: "20191225"
    rating: "G"
  }])

p "Created #{Movie.count} movies"


t.string "title"
    t.string "description"
    t.string "genre"
    t.datetime "release_date"
    t.string "rating"