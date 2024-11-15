require "open-uri"
require "json"

Bookmark.destroy_all
Movie.destroy_all

url = "https://tmdb.lewagon.com/movie/top_rated"
movie_list = URI.open(url).read
movies = JSON.parse(movie_list)["results"]

puts "Creating movies..."

movies.each do |movie|
  Movie.create(
    title: movie["original_title"],
    overview: movie["overview"],
    poster_url: "https://image.tmdb.org/t/p/original#{movie["backdrop_path"]}",
    rating: movie["vote_average"].round(1))
end

puts "#{Movie.count} movies created!"
