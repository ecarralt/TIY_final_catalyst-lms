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

ActiveRecord::Schema.define(version: 20160729194048) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "assignmentrecords", force: :cascade do |t|
    t.text     "comments"
    t.string   "url_link"
    t.string   "contentfile_id"
    t.string   "contentfile_content_type"
    t.string   "contentfile_filename"
    t.integer  "contentfile_size"
    t.string   "score"
    t.text     "instructor_feedback"
    t.string   "graded_by"
    t.integer  "user_id"
    t.integer  "assignment_id"
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  add_index "assignmentrecords", ["assignment_id"], name: "index_assignmentrecords_on_assignment_id", using: :btree
  add_index "assignmentrecords", ["user_id"], name: "index_assignmentrecords_on_user_id", using: :btree

  create_table "assignments", force: :cascade do |t|
    t.string   "title"
    t.text     "content"
    t.string   "author"
    t.string   "released",          default: "0"
    t.integer  "assignment_number"
    t.integer  "user_id"
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
  end

  add_index "assignments", ["user_id"], name: "index_assignments_on_user_id", using: :btree

  create_table "lessonrecords", force: :cascade do |t|
    t.string   "complete",   default: "no"
    t.integer  "user_id"
    t.integer  "lesson_id"
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
  end

  add_index "lessonrecords", ["lesson_id"], name: "index_lessonrecords_on_lesson_id", using: :btree
  add_index "lessonrecords", ["user_id"], name: "index_lessonrecords_on_user_id", using: :btree

  create_table "lessons", force: :cascade do |t|
    t.string   "title"
    t.text     "content"
    t.string   "author"
    t.integer  "lesson_number"
    t.string   "released",      default: "0"
    t.integer  "user_id"
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
  end

  add_index "lessons", ["user_id"], name: "index_lessons_on_user_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "email"
    t.string   "username"
    t.string   "password_digest", null: false
    t.string   "photofile_id"
    t.string   "usertype"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

end
