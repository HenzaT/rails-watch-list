# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
require 'json'
require 'open-uri'

puts "Cleaning database..."
Movie.destroy_all

url = 'https://tmdb.lewagon.com/movie/top_rated'
initial_path = 'https://image.tmdb.org/t/p/w500'

movies_json = URI.parse(url).read
movies = JSON.parse(movies_json)

movies['results'].each do |movie|
  puts 'Creating movie...'
  Movie.create!(title: "#{movie['title']}", overview: "#{movie['overview']}", poster_url: initial_path + movie['poster_path'], rating: "#{movie['vote_average']}")
end

puts "Finished! Created #{Movie.count} movies!"
