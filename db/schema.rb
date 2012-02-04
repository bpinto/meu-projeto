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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20120204022701) do

  create_table "cities", :force => true do |t|
    t.string   "name",       :null => false
    t.string   "state",      :null => false
    t.string   "country",    :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "cities", ["name"], :name => "index_cities_on_name"

  create_table "cities_users", :id => false, :force => true do |t|
    t.integer "city_id", :null => false
    t.integer "user_id", :null => false
  end

  create_table "comments", :force => true do |t|
    t.string   "title",            :limit => 50, :default => ""
    t.text     "comment"
    t.integer  "commentable_id"
    t.string   "commentable_type"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "comments", ["commentable_id"], :name => "index_comments_on_commentable_id"
  add_index "comments", ["commentable_type"], :name => "index_comments_on_commentable_type"
  add_index "comments", ["user_id"], :name => "index_comments_on_user_id"

  create_table "deals", :force => true do |t|
    t.text     "description",                                              :null => false
    t.text     "link",                                                     :null => false
    t.string   "title",                                                    :null => false
    t.integer  "user_id",                                                  :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "address"
    t.integer  "category",                                                 :null => false
    t.string   "company",                                                  :null => false
    t.decimal  "discount",    :precision => 8, :scale => 2
    t.datetime "end_date"
    t.decimal  "real_price",  :precision => 8, :scale => 2
    t.integer  "kind",                                                     :null => false
    t.decimal  "price",       :precision => 8, :scale => 2
    t.integer  "city_id",                                                  :null => false
    t.integer  "up_votes",                                  :default => 0, :null => false
    t.integer  "down_votes",                                :default => 0, :null => false
  end

  add_index "deals", ["city_id"], :name => "index_deals_on_city_id"

  create_table "relationships", :force => true do |t|
    t.integer  "followed_id", :null => false
    t.integer  "follower_id", :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", :force => true do |t|
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "email",                                 :default => "", :null => false
    t.string   "encrypted_password",     :limit => 128, :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                         :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name"
    t.string   "username",                                              :null => false
    t.integer  "up_votes",                              :default => 0,  :null => false
    t.integer  "down_votes",                            :default => 0,  :null => false
    t.string   "uid"
    t.string   "provider"
    t.string   "avatar_url"
    t.string   "access_token"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true
  add_index "users", ["username"], :name => "index_users_on_username", :unique => true

  create_table "versions", :force => true do |t|
    t.string   "item_type",  :null => false
    t.integer  "item_id",    :null => false
    t.string   "event",      :null => false
    t.string   "whodunnit"
    t.text     "object"
    t.datetime "created_at"
  end

  add_index "versions", ["item_type", "item_id"], :name => "index_versions_on_item_type_and_item_id"

  create_table "votings", :force => true do |t|
    t.string   "voteable_type"
    t.integer  "voteable_id"
    t.string   "voter_type"
    t.integer  "voter_id"
    t.boolean  "up_vote",       :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "votings", ["voteable_type", "voteable_id", "voter_type", "voter_id"], :name => "unique_voters", :unique => true
  add_index "votings", ["voteable_type", "voteable_id"], :name => "index_votings_on_voteable_type_and_voteable_id"
  add_index "votings", ["voter_type", "voter_id"], :name => "index_votings_on_voter_type_and_voter_id"

end
