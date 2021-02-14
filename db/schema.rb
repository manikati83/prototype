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

ActiveRecord::Schema.define(version: 2021_02_13_112113) do

  create_table "applies", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "worker_id"
    t.bigint "request_id"
    t.string "content"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["request_id"], name: "index_applies_on_request_id"
    t.index ["worker_id", "request_id"], name: "index_applies_on_worker_id_and_request_id", unique: true
    t.index ["worker_id"], name: "index_applies_on_worker_id"
  end

  create_table "client_evaluations", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "work_id"
    t.float "evaluation"
    t.string "content"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id", "work_id"], name: "index_client_evaluations_on_user_id_and_work_id", unique: true
    t.index ["user_id"], name: "index_client_evaluations_on_user_id"
    t.index ["work_id"], name: "index_client_evaluations_on_work_id"
  end

  create_table "requests", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "client_id"
    t.string "title"
    t.text "content"
    t.integer "status", default: 0
    t.string "image"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.date "apply_days"
    t.date "deadline"
    t.index ["client_id"], name: "index_requests_on_client_id"
  end

  create_table "talks", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "work_id"
    t.string "content"
    t.string "image"
    t.integer "status", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_talks_on_user_id"
    t.index ["work_id"], name: "index_talks_on_work_id"
  end

  create_table "users", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.string "password_digest"
    t.string "content"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "image"
  end

  create_table "worker_evaluations", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "work_id"
    t.float "evaluation"
    t.string "content"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id", "work_id"], name: "index_worker_evaluations_on_user_id_and_work_id", unique: true
    t.index ["user_id"], name: "index_worker_evaluations_on_user_id"
    t.index ["work_id"], name: "index_worker_evaluations_on_work_id"
  end

  create_table "works", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "request_id"
    t.bigint "worker_id"
    t.string "image"
    t.date "deadline"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["request_id"], name: "index_works_on_request_id"
    t.index ["worker_id"], name: "index_works_on_worker_id"
  end

  add_foreign_key "applies", "requests"
  add_foreign_key "applies", "users", column: "worker_id"
  add_foreign_key "client_evaluations", "users"
  add_foreign_key "client_evaluations", "works"
  add_foreign_key "requests", "users", column: "client_id"
  add_foreign_key "talks", "users"
  add_foreign_key "talks", "works"
  add_foreign_key "worker_evaluations", "users"
  add_foreign_key "worker_evaluations", "works"
  add_foreign_key "works", "requests"
  add_foreign_key "works", "users", column: "worker_id"
end
