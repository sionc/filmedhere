# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20140126230858) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "filming_locations", force: true do |t|
    t.integer  "film_id"
    t.integer  "location_id"
    t.text     "fun_facts"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "films", force: true do |t|
    t.string   "title"
    t.integer  "release_year"
    t.string   "production_company"
    t.string   "distributor"
    t.string   "director"
    t.string   "writers"
    t.string   "actors"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "locations", force: true do |t|
    t.string   "raw_address"
    t.string   "formatted_address"
    t.decimal  "latitude",          precision: 10, scale: 8
    t.decimal  "longitude",         precision: 11, scale: 8
    t.text     "icon_url"
    t.string   "name"
    t.decimal  "rating",            precision: 3,  scale: 2
    t.string   "google_places_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
