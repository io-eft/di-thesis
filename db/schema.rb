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

ActiveRecord::Schema.define(version: 20160227214844) do

  create_table "announcements", force: :cascade do |t|
    t.string   "title"
    t.string   "message"
    t.integer  "course_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "announcements", ["course_id"], name: "index_announcements_on_course_id"

  create_table "assignments", force: :cascade do |t|
    t.string   "title"
    t.text     "description"
    t.date     "due_date"
    t.integer  "course_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "assignments", ["course_id"], name: "index_assignments_on_course_id"

  create_table "courses", force: :cascade do |t|
    t.string   "code",        null: false
    t.string   "name",        null: false
    t.integer  "lecturer_id"
    t.text     "description"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "documents", force: :cascade do |t|
    t.string   "name"
    t.string   "doc"
    t.integer  "assignment_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  add_index "documents", ["assignment_id", "doc"], name: "index_documents_on_assignment_id_and_doc", unique: true
  add_index "documents", ["assignment_id"], name: "index_documents_on_assignment_id"

  create_table "homeworks", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "assignment_id"
    t.string   "hw"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  add_index "homeworks", ["assignment_id"], name: "index_homeworks_on_assignment_id"
  add_index "homeworks", ["user_id"], name: "index_homeworks_on_user_id"

  create_table "roles", force: :cascade do |t|
    t.string   "name"
    t.integer  "resource_id"
    t.string   "resource_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "roles", ["name", "resource_type", "resource_id"], name: "index_roles_on_name_and_resource_type_and_resource_id"
  add_index "roles", ["name"], name: "index_roles_on_name"

  create_table "student_attends_courses", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "course_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "student_attends_courses", ["course_id"], name: "index_student_attends_courses_on_course_id"
  add_index "student_attends_courses", ["user_id"], name: "index_student_attends_courses_on_user_id"

  create_table "users", force: :cascade do |t|
    t.string   "name",                               null: false
    t.string   "surname",                            null: false
    t.string   "email",                              null: false
    t.string   "encrypted_password",                 null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                         null: false
    t.datetime "updated_at",                         null: false
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true

  create_table "users_roles", id: false, force: :cascade do |t|
    t.integer "user_id"
    t.integer "role_id"
  end

  add_index "users_roles", ["user_id", "role_id"], name: "index_users_roles_on_user_id_and_role_id"

end
