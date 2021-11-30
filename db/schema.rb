# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2021_11_21_153001) do

  create_table "follows", force: :cascade do |t|
    t.integer "user_id", null: false
    t.string "interest_type", null: false
    t.integer "interest_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["interest_type", "interest_id"], name: "index_follows_on_interest"
    t.index ["user_id"], name: "index_follows_on_user_id"
  end

  create_table "genres", force: :cascade do |t|
    t.string "title"
    t.text "description"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["title"], name: "index_genres_on_title", unique: true
  end

  create_table "genres_movies", id: false, force: :cascade do |t|
    t.integer "movie_id", null: false
    t.integer "genre_id", null: false
    t.index ["genre_id"], name: "index_genres_movies_on_genre_id"
    t.index ["movie_id", "genre_id"], name: "index_genres_movies_on_movie_id_and_genre_id", unique: true
    t.index ["movie_id"], name: "index_genres_movies_on_movie_id"
  end

  create_table "movies", force: :cascade do |t|
    t.string "original_title"
    t.string "description"
    t.date "release_date"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["original_title", "release_date"], name: "index_movies_on_original_title_and_release_date", unique: true
  end

  create_table "roles", id: false, force: :cascade do |t|
    t.integer "movie_id", null: false
    t.integer "star_id", null: false
    t.string "title", null: false
    t.boolean "is_acting", default: true
    t.index ["movie_id", "star_id"], name: "index_roles_on_movie_id_and_star_id"
    t.index ["movie_id"], name: "index_roles_on_movie_id"
    t.index ["star_id"], name: "index_roles_on_star_id"
  end

  create_table "stars", force: :cascade do |t|
    t.string "full_name"
    t.text "biography"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "email_address"
    t.string "password_digest"
    t.string "password_reset"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "email_confirmation"
    t.datetime "email_confirmation_sent_at"
    t.boolean "email_confirmed", default: false
    t.index ["email_address"], name: "index_users_on_email_address", unique: true
    t.index ["email_confirmation"], name: "index_users_on_email_confirmation", unique: true
    t.index ["password_reset"], name: "index_users_on_password_reset", unique: true
  end

  add_foreign_key "follows", "users"
end
