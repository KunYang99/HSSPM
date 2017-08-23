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

ActiveRecord::Schema.define(version: 20170822152518) do

  create_table "carts", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "user_id"
    t.integer  "human_sample_id"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.index ["human_sample_id"], name: "index_carts_on_human_sample_id", using: :btree
    t.index ["user_id"], name: "index_carts_on_user_id", using: :btree
  end

  create_table "clinic_files", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "title"
    t.string   "file"
    t.text     "note",       limit: 65535
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  create_table "cohorts", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "name"
    t.text     "note",       limit: 65535
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  create_table "cohorts_humen", id: false, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer "human_id",  null: false
    t.integer "cohort_id", null: false
    t.index ["human_id", "cohort_id"], name: "index_cohorts_humen_on_human_id_and_cohort_id", using: :btree
  end

  create_table "datasets", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "human_id"
    t.string   "title"
    t.string   "file"
    t.text     "availability", limit: 65535
    t.text     "contributors", limit: 65535
    t.string   "pi"
    t.string   "note"
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.index ["human_id"], name: "index_datasets_on_human_id", using: :btree
  end

  create_table "datasets_projects", id: false, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer "dataset_id", null: false
    t.integer "project_id", null: false
    t.index ["dataset_id", "project_id"], name: "index_datasets_projects_on_dataset_id_and_project_id", using: :btree
  end

  create_table "demographies", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "human_id"
    t.text     "data",       limit: 4294967295
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
    t.index ["human_id"], name: "index_demographies_on_human_id", using: :btree
  end

  create_table "events", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "title"
    t.datetime "start"
    t.datetime "stop"
    t.string   "place"
    t.text     "note",       limit: 65535
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  create_table "fav_samples", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "user_id"
    t.integer  "human_sample_id"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.index ["human_sample_id"], name: "index_fav_samples_on_human_sample_id", using: :btree
    t.index ["user_id"], name: "index_fav_samples_on_user_id", using: :btree
  end

  create_table "fav_subjects", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "user_id"
    t.integer  "human_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["human_id"], name: "index_fav_subjects_on_human_id", using: :btree
    t.index ["user_id"], name: "index_fav_subjects_on_user_id", using: :btree
  end

  create_table "genders", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "name"
    t.text     "note",       limit: 65535
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  create_table "groups", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "name"
    t.text     "note",       limit: 65535
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  create_table "groups_users", id: false, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer "group_id", null: false
    t.integer "user_id",  null: false
    t.index ["group_id", "user_id"], name: "index_groups_users_on_group_id_and_user_id", using: :btree
  end

  create_table "human_samples", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "sample_type_id"
    t.integer  "visit_id"
    t.string   "amount"
    t.date     "created_on"
    t.integer  "main_location_id"
    t.string   "sub_location"
    t.string   "source"
    t.string   "prepared_by"
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
    t.text     "note",             limit: 65535
    t.string   "accession"
    t.string   "concentration"
    t.string   "avail_amount"
    t.index ["main_location_id"], name: "index_human_samples_on_main_location_id", using: :btree
    t.index ["sample_type_id"], name: "index_human_samples_on_sample_type_id", using: :btree
    t.index ["visit_id"], name: "index_human_samples_on_visit_id", using: :btree
  end

  create_table "humen", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "accession"
    t.text     "other_ids",     limit: 65535
    t.integer  "population_id"
    t.integer  "gender_id"
    t.text     "note",          limit: 65535
    t.integer  "status_id"
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
    t.index ["gender_id"], name: "index_humen_on_gender_id", using: :btree
    t.index ["population_id"], name: "index_humen_on_population_id", using: :btree
    t.index ["status_id"], name: "index_humen_on_status_id", using: :btree
  end

  create_table "humen_irbs", id: false, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer "human_id", null: false
    t.integer "irb_id",   null: false
    t.index ["human_id", "irb_id"], name: "index_humen_irbs_on_human_id_and_irb_id", using: :btree
  end

  create_table "humen_races", id: false, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer "human_id", null: false
    t.integer "race_id",  null: false
    t.index ["human_id", "race_id"], name: "index_humen_races_on_human_id_and_race_id", using: :btree
  end

  create_table "irbs", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "number"
    t.text     "name",       limit: 65535
    t.string   "pi"
    t.text     "note",       limit: 65535
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
    t.string   "url"
  end

  create_table "main_locations", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "name"
    t.text     "location",   limit: 65535
    t.text     "note",       limit: 65535
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  create_table "materials", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "title"
    t.string   "file"
    t.string   "note"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "populations", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "name"
    t.text     "note",       limit: 65535
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  create_table "projects", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "name"
    t.text     "description", limit: 65535
    t.string   "PI"
    t.text     "members",     limit: 65535
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
    t.integer  "progress"
  end

  create_table "races", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "name"
    t.text     "note",       limit: 65535
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  create_table "sample_types", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "name"
    t.text     "note",       limit: 65535
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  create_table "statuses", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "name"
    t.text     "note",       limit: 65535
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  create_table "transfers", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "human_sample_id"
    t.string   "trans_from"
    t.string   "trans_to"
    t.string   "amount"
    t.text     "note",            limit: 65535
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
    t.index ["human_sample_id"], name: "index_transfers_on_human_sample_id", using: :btree
  end

  create_table "users", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "name"
    t.string   "gmail"
    t.string   "phone"
    t.string   "email"
    t.string   "password_digest"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.string   "username"
  end

  create_table "visit_types", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "value"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "visits", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "human_id"
    t.integer  "visit_type_id"
    t.text     "diagnosis",     limit: 65535
    t.text     "note",          limit: 65535
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
    t.integer  "age"
    t.date     "visit_date"
    t.index ["human_id"], name: "index_visits_on_human_id", using: :btree
    t.index ["visit_type_id"], name: "index_visits_on_visit_type_id", using: :btree
  end

  add_foreign_key "demographies", "humen"
  add_foreign_key "transfers", "human_samples"
end
