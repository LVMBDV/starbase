# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require "csv"
require "date"
require "json"
require "progressbar"

movies_by_imdb_id = {}

progress_bar = ProgressBar.create(:title => "Creating movies")
CSV.foreach(File.join(__dir__, "imdb_dataset", "movies.csv"), headers: true).with_index do |row, index|
  begin
    genres = row["genre"].split(",").map { |genre_title| Genre.find_or_create_by(title: genre_title) }
    movie = Movie.create(original_title: row["original_title"], release_date: Date.parse(row["date_published"]), genres: genres)
    progress_bar.progress = (index + 1) * 100 / 5000
    movies_by_imdb_id[row["imdb_title_id"]] = movie.id
  rescue
    # life is too short to clean other people's data
    next
  end
end

puts "\nCreated #{Movie.count} movies in #{Genre.count} genres"

stars_by_imdb_id = {}

progress_bar = ProgressBar.create(:title => "Creating stars")
CSV.foreach(File.join(__dir__, "imdb_dataset", "names.csv"), headers: true).with_index do |row, index|
  star = Star.create(full_name: row["name"])
  progress_bar.progress = (index + 1) * 100 / 5000
  stars_by_imdb_id[row["imdb_name_id"]] = star.id
end

puts "\nCreated #{Star.count} stars"

progress_bar = ProgressBar.create(:title => "Creating roles")
CSV.foreach(File.join(__dir__, "imdb_dataset", "roles.csv"), headers: true).with_index do |row, index|
  movie_id = movies_by_imdb_id[row["imdb_title_id"]]
  star_id = stars_by_imdb_id[row["imdb_name_id"]]

  unless movie_id.present? && star_id.present?
    # might have been lost due to truncation
    next
  end

  movie = Movie.find(movie_id)
  star = Star.find(star_id)
  progress_bar.progress = (index + 1) * 100 / 10000

  unless movie.present? && star.present?
    # life is too short to clean other people's data
    next
  end

  is_acting = ["actor", "actress"].include? row["category"]
  if is_acting
    JSON.parse(row["characters"] || "[]").each do |character|
      Role.create(movie: movie, star: star, title: character, is_acting: true)
    end
  else
    Role.create(movie: movie, star: star, title: row["category"].titleize, is_acting: false)
  end
end

puts "\nCreated #{Role.count} roles"
