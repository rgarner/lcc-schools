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

ActiveRecord::Schema.define(version: 20151105161053) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "postgis"

  create_table "addresses", force: :cascade do |t|
    t.string   "name_or_number"
    t.string   "postcode"
    t.float    "latitude"
    t.float    "longitude"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  create_table "schools", force: :cascade do |t|
    t.string   "code"
    t.string   "name"
    t.string   "phase"
    t.string   "address1"
    t.string   "address2"
    t.string   "address3"
    t.string   "telephone"
    t.string   "postcode"
    t.string   "headteacher"
    t.integer  "number_of_pupils"
    t.geometry "centroid",             limit: {:srid=>0, :type=>"point"}
    t.string   "email"
    t.string   "website"
    t.string   "ofsted_report"
    t.integer  "available_places"
    t.integer  "number_of_admissions"
    t.datetime "created_at",                                              null: false
    t.datetime "updated_at",                                              null: false
    t.float    "nearest"
    t.float    "non_nearest"
    t.integer  "priority1a"
    t.integer  "priority1b"
    t.integer  "priority2"
    t.integer  "priority3"
    t.integer  "priority4"
    t.integer  "priority5"
    t.integer  "from_age"
    t.integer  "to_age"
    t.boolean  "not_all_nearest"
    t.string   "type"
  end

  add_index "schools", ["centroid"], name: "index_schools_on_centroid", using: :gist

end
