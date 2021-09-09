# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2021_08_10_091538) do

  create_table "admins", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "nickname"
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["email"], name: "index_admins_on_email", unique: true
    t.index ["reset_password_token"], name: "index_admins_on_reset_password_token", unique: true
  end

  create_table "article_quests", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "article_id", null: false
    t.bigint "quest_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["article_id"], name: "index_article_quests_on_article_id"
    t.index ["quest_id"], name: "index_article_quests_on_quest_id"
  end

  create_table "articles", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "title", null: false
    t.text "content", null: false
    t.integer "level", null: false
    t.integer "genre", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "quests", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.text "question"
    t.string "select1"
    t.string "select2"
    t.string "select3"
    t.string "select4"
    t.string "answer"
    t.text "explain"
    t.integer "genre"
    t.integer "level"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "scores", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "article_id", null: false
    t.integer "score", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["article_id"], name: "index_scores_on_article_id"
    t.index ["user_id"], name: "index_scores_on_user_id"
  end

  create_table "user_quests", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "quest_id", null: false
    t.integer "repeat"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["quest_id"], name: "index_user_quests_on_quest_id"
    t.index ["user_id"], name: "index_user_quests_on_user_id"
  end

  create_table "users", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "nickname"
    t.integer "rank_id", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "article_quests", "articles"
  add_foreign_key "article_quests", "quests"
  add_foreign_key "scores", "articles"
  add_foreign_key "scores", "users"
  add_foreign_key "user_quests", "quests"
  add_foreign_key "user_quests", "users"
end

Article.create!(
  title:"サンプル記事１",
  content:"<p>問題文をセット</p>",
  genre:1,
  level:1
)
Quest.create!(
  title: "四字熟語1",
  content: "<p>問題文をセットする</p>",
  genre: 0,
  level: 0
)
Quest.create!(
  title: "四字熟語2",
  content: "<p>問題文をセットする</p>",
  genre: 0,
  level: 0
)
Quest.create!(
  title: "四字熟語3",
  content: "<p>問題文をセットする</p>",
  genre: 0,
  level: 0
)
Quest.create!(
  title: "四字熟語4",
  content: "<p>問題文をセットする</p>",
  genre: 0,
  level: 0
)
Quest.create!(
  title: "四字熟語5",
  content: "<p>問題文をセットする</p>",
  genre: 0,
  level: 0
)
Quest.create!(
  title: "四字熟語6",
  content: "<p>問題文をセットする</p>",
  genre: 0,
  level: 1
)
Quest.create!(
  title: "四字熟語7",
  content: "<p>問題文をセットする</p>",
  genre: 0,
  level: 1
)
Quest.create!(
  title: "四字熟語8",
  content: "<p>問題文をセットする</p>",
  genre: 0,
  level: 1
)
Quest.create!(
  title: "四字熟語9",
  content: "<p>問題文をセットする</p>",
  genre: 0,
  level: 1
)
Quest.create!(
  title: "四字熟語10",
  content: "<p>問題文をセットする</p>",
  genre: 0,
  level: 1
)
Quest.create!(
  title: "四字熟語11",
  content: "<p>問題文をセットする</p>",
  genre: 0,
  level: 2
)
Quest.create!(
  title: "四字熟語12",
  content: "<p>問題文をセットする</p>",
  genre: 0,
  level: 2
)
Quest.create!(
  title: "四字熟語13",
  content: "<p>問題文をセットする</p>",
  genre: 0,
  level: 2
)
Quest.create!(
  title: "四字熟語14",
  content: "<p>問題文をセットする</p>",
  genre: 0,
  level: 2
)
Quest.create!(
  title: "四字熟語15",
  content: "<p>問題文をセットする</p>",
  genre: 0,
  level: 2
)
Quest.create!(
  title: "四字熟語16",
  content: "<p>問題文をセットする</p>",
  genre: 0,
  level: 3
)
Quest.create!(
  title: "四字熟語17",
  content: "<p>問題文をセットする</p>",
  genre: 0,
  level: 3
)
Quest.create!(
  title: "四字熟語18",
  content: "<p>問題文をセットする</p>",
  genre: 0,
  level: 3
)
Quest.create!(
  title: "四字熟語19",
  content: "<p>問題文をセットする</p>",
  genre: 0,
  level: 3
)
Quest.create!(
  title: "四字熟語20",
  content: "<p>問題文をセットする</p>",
  genre: 0,
  level: 3
)
Quest.create!(
  title: "四字熟語21",
  content: "<p>問題文をセットする</p>",
  genre: 0,
  level: 4
)

Quest.create!(
  title: "故事・諺1",
  content: "<p>問題文をセットする</p>",
  genre: 1,
  level: 0
)
Quest.create!(
  title: "故事2",
  content: "<p>問題文をセットする</p>",
  genre: 1,
  level: 0
)
Quest.create!(
  title: "故事・諺3",
  content: "<p>問題文をセットする</p>",
  genre: 1,
  level: 0
)
Quest.create!(
  title: "故事・諺4",
  content: "<p>問題文をセットする</p>",
  genre: 1,
  level: 0
)
Quest.create!(
  title: "故事・諺5",
  content: "<p>問題文をセットする</p>",
  genre: 1,
  level: 0
)
Quest.create!(
  title: "故事・諺6",
  content: "<p>問題文をセットする</p>",
  genre: 1,
  level: 1
)
Quest.create!(
  title: "故事・諺7",
  content: "<p>問題文をセットする</p>",
  genre: 1,
  level: 1
)
Quest.create!(
  title: "故事・諺8",
  content: "<p>問題文をセットする</p>",
  genre: 1,
  level: 1
)
Quest.create!(
  title: "故事・諺9",
  content: "<p>問題文をセットする</p>",
  genre: 1,
  level: 1
)
Quest.create!(
  title: "故事・諺10",
  content: "<p>問題文をセットする</p>",
  genre: 1,
  level: 1
)
Quest.create!(
  title: "故事・諺11",
  content: "<p>問題文をセットする</p>",
  genre: 1,
  level: 2
)
Quest.create!(
  title: "故事・諺12",
  content: "<p>問題文をセットする</p>",
  genre: 1,
  level: 2
)
Quest.create!(
  title: "故事・諺13",
  content: "<p>問題文をセットする</p>",
  genre: 1,
  level: 2
)
Quest.create!(
  title: "故事・諺14",
  content: "<p>問題文をセットする</p>",
  genre: 1,
  level: 2
)
Quest.create!(
  title: "故事・諺15",
  content: "<p>問題文をセットする</p>",
  genre: 1,
  level: 2
)
Quest.create!(
  title: "故事・諺16",
  content: "<p>問題文をセットする</p>",
  genre: 1,
  level: 3
)
Quest.create!(
  title: "故事・諺17",
  content: "<p>問題文をセットする</p>",
  genre: 1,
  level: 3
)
Quest.create!(
  title: "故事・諺18",
  content: "<p>問題文をセットする</p>",
  genre: 1,
  level: 3
)
Quest.create!(
  title: "故事・諺19",
  content: "<p>問題文をセットする</p>",
  genre: 1,
  level: 3
)
Quest.create!(
  title: "故事・諺20",
  content: "<p>問題文をセットする</p>",
  genre: 1,
  level: 3
)
Quest.create!(
  title: "故事・諺21",
  content: "<p>問題文をセットする</p>",
  genre: 1,
  level: 4
)
Quest.create!(
  title: "熟語訓・当て字1",
  content: "<p>問題文をセットする</p>",
  genre: 2,
  level: 0
)
Quest.create!(
  title: "熟語訓・当て字2",
  content: "<p>問題文をセットする</p>",
  genre: 2,
  level: 0
)
Quest.create!(
  title: "熟語訓・当て字3",
  content: "<p>問題文をセットする</p>",
  genre: 2,
  level: 0
)
Quest.create!(
  title: "熟語訓・当て字4",
  content: "<p>問題文をセットする</p>",
  genre: 2,
  level: 0
)
Quest.create!(
  title: "熟語訓・当て字5",
  content: "<p>問題文をセットする</p>",
  genre: 2,
  level: 0
)
Quest.create!(
  title: "熟語訓・当て字6",
  content: "<p>問題文をセットする</p>",
  genre: 2,
  level: 1
)
Quest.create!(
  title: "熟語訓・当て字7",
  content: "<p>問題文をセットする</p>",
  genre: 2,
  level: 1
)
Quest.create!(
  title: "熟語訓・当て字8",
  content: "<p>問題文をセットする</p>",
  genre: 2,
  level: 1
)
Quest.create!(
  title: "熟語訓・当て字9",
  content: "<p>問題文をセットする</p>",
  genre: 2,
  level: 1
)
Quest.create!(
  title: "熟語訓・当て字10",
  content: "<p>問題文をセットする</p>",
  genre: 2,
  level: 1
)
Quest.create!(
  title: "熟語訓・当て字11",
  content: "<p>問題文をセットする</p>",
  genre: 2,
  level: 2
)
Quest.create!(
  title: "熟語訓・当て字12",
  content: "<p>問題文をセットする</p>",
  genre: 2,
  level: 2
)
Quest.create!(
  title: "熟語訓・当て字13",
  content: "<p>問題文をセットする</p>",
  genre: 2,
  level: 2
)
Quest.create!(
  title: "熟語訓・当て字14",
  content: "<p>問題文をセットする</p>",
  genre: 2,
  level: 2
)
Quest.create!(
  title: "熟語訓・当て字15",
  content: "<p>問題文をセットする</p>",
  genre: 2,
  level: 2
)
Quest.create!(
  title: "熟語訓・当て字16",
  content: "<p>問題文をセットする</p>",
  genre: 2,
  level: 3
)
Quest.create!(
  title: "熟語訓・当て字17",
  content: "<p>問題文をセットする</p>",
  genre: 2,
  level: 3
)
Quest.create!(
  title: "熟語訓・当て字18",
  content: "<p>問題文をセットする</p>",
  genre: 2,
  level: 3
)
Quest.create!(
  title: "熟語訓・当て字19",
  content: "<p>問題文をセットする</p>",
  genre: 2,
  level: 3
)
Quest.create!(
  title: "熟語訓・当て字20",
  content: "<p>問題文をセットする</p>",
  genre: 2,
  level: 3
)
Quest.create!(
  title: "熟語訓・当て字21",
  content: "<p>問題文をセットする</p>",
  genre: 2,
  level: 4
)
Quest.create!(
  title: "読み取り1",
  content: "<p>問題文をセットする</p>",
  genre: 3,
  level: 0
)
Quest.create!(
  title: "読み取り2",
  content: "<p>問題文をセットする</p>",
  genre: 3,
  level: 0
)
Quest.create!(
  title: "読み取り3",
  content: "<p>問題文をセットする</p>",
  genre: 3,
  level: 0
)
Quest.create!(
  title: "読み取り4",
  content: "<p>問題文をセットする</p>",
  genre: 3,
  level: 0
)
Quest.create!(
  title: "読み取り5",
  content: "<p>問題文をセットする</p>",
  genre: 3,
  level: 0
)
Quest.create!(
  title: "読み取り6",
  content: "<p>問題文をセットする</p>",
  genre: 3,
  level: 1
)
Quest.create!(
  title: "読み取り7",
  content: "<p>問題文をセットする</p>",
  genre: 3,
  level: 1
)
Quest.create!(
  title: "読み取り8",
  content: "<p>問題文をセットする</p>",
  genre: 3,
  level: 1
)
Quest.create!(
  title: "読み取り9",
  content: "<p>問題文をセットする</p>",
  genre: 3,
  level: 1
)
Quest.create!(
  title: "読み取り10",
  content: "<p>問題文をセットする</p>",
  genre: 3,
  level: 1
)
Quest.create!(
  title: "読み取り11",
  content: "<p>問題文をセットする</p>",
  genre: 3,
  level: 2
)
Quest.create!(
  title: "読み取り12",
  content: "<p>問題文をセットする</p>",
  genre: 3,
  level: 2
)
Quest.create!(
  title: "読み取り13",
  content: "<p>問題文をセットする</p>",
  genre: 3,
  level: 2
)
Quest.create!(
  title: "読み取り14",
  content: "<p>問題文をセットする</p>",
  genre: 3,
  level: 2
)
Quest.create!(
  title: "読み取り15",
  content: "<p>問題文をセットする</p>",
  genre: 3,
  level: 2
)
Quest.create!(
  title: "読み取り16",
  content: "<p>問題文をセットする</p>",
  genre: 3,
  level: 3
)
Quest.create!(
  title: "読み取り17",
  content: "<p>問題文をセットする</p>",
  genre: 3,
  level: 3
)
Quest.create!(
  title: "読み取り18",
  content: "<p>問題文をセットする</p>",
  genre: 3,
  level: 3
)
Quest.create!(
  title: "読み取り19",
  content: "<p>問題文をセットする</p>",
  genre: 3,
  level: 3
)
Quest.create!(
  title: "読み取り20",
  content: "<p>問題文をセットする</p>",
  genre: 3,
  level: 3
)
Quest.create!(
  title: "読み取り21",
  content: "<p>問題文をセットする</p>",
  genre: 3,
  level: 4
)
Quest.create!(
  title: "書き取り1",
  content: "<p>問題文をセットする</p>",
  genre: 4,
  level: 0
)
Quest.create!(
  title: "書き取り2",
  content: "<p>問題文をセットする</p>",
  genre: 4,
  level: 0
)
Quest.create!(
  title: "書き取り3",
  content: "<p>問題文をセットする</p>",
  genre: 4,
  level: 0
)
Quest.create!(
  title: "書き取り4",
  content: "<p>問題文をセットする</p>",
  genre: 4,
  level: 0
)
Quest.create!(
  title: "書き取り5",
  content: "<p>問題文をセットする</p>",
  genre: 4,
  level: 0
)
Quest.create!(
  title: "書き取り6",
  content: "<p>問題文をセットする</p>",
  genre: 4,
  level: 1
)
Quest.create!(
  title: "書き取り7",
  content: "<p>問題文をセットする</p>",
  genre: 4,
  level: 1
)
Quest.create!(
  title: "書き取り8",
  content: "<p>問題文をセットする</p>",
  genre: 4,
  level: 1
)
Quest.create!(
  title: "書き取り9",
  content: "<p>問題文をセットする</p>",
  genre: 4,
  level: 1
)
Quest.create!(
  title: "書き取り10",
  content: "<p>問題文をセットする</p>",
  genre: 4,
  level: 1
)
Quest.create!(
  title: "書き取り11",
  content: "<p>問題文をセットする</p>",
  genre: 4,
  level: 2
)
Quest.create!(
  title: "書き取り12",
  content: "<p>問題文をセットする</p>",
  genre: 4,
  level: 2
)
Quest.create!(
  title: "書き取り13",
  content: "<p>問題文をセットする</p>",
  genre: 4,
  level: 2
)
Quest.create!(
  title: "書き取り14",
  content: "<p>問題文をセットする</p>",
  genre: 4,
  level: 2
)
Quest.create!(
  title: "書き取り15",
  content: "<p>問題文をセットする</p>",
  genre: 4,
  level: 2
)
Quest.create!(
  title: "書き取り16",
  content: "<p>問題文をセットする</p>",
  genre: 4,
  level: 3
)
Quest.create!(
  title: "書き取り17",
  content: "<p>問題文をセットする</p>",
  genre: 4,
  level: 3
)
Quest.create!(
  title: "書き取り18",
  content: "<p>問題文をセットする</p>",
  genre: 4,
  level: 3
)
Quest.create!(
  title: "書き取り19",
  content: "<p>問題文をセットする</p>",
  genre: 4,
  level: 3
)
Quest.create!(
  title: "書き取り20",
  content: "<p>問題文をセットする</p>",
  genre: 4,
  level: 3
)
Quest.create!(
  title: "書き取り21",
  content: "<p>問題文をセットする</p>",
  genre: 4,
  level: 4
)
Quest.create!(
  title: "国字1",
  content: "<p>問題文をセットする</p>",
  genre: 5,
  level: 0
)
Quest.create!(
  title: "国字2",
  content: "<p>問題文をセットする</p>",
  genre: 5,
  level: 0
)
Quest.create!(
  title: "国字3",
  content: "<p>問題文をセットする</p>",
  genre: 5,
  level: 0
)
Quest.create!(
  title: "国字4",
  content: "<p>問題文をセットする</p>",
  genre: 5,
  level: 0
)
Quest.create!(
  title: "国字5",
  content: "<p>問題文をセットする</p>",
  genre: 5,
  level: 0
)
Quest.create!(
  title: "国字6",
  content: "<p>問題文をセットする</p>",
  genre: 5,
  level: 1
)
Quest.create!(
  title: "国字7",
  content: "<p>問題文をセットする</p>",
  genre: 5,
  level: 1
)
Quest.create!(
  title: "国字8",
  content: "<p>問題文をセットする</p>",
  genre: 5,
  level: 1
)
Quest.create!(
  title: "国字9",
  content: "<p>問題文をセットする</p>",
  genre: 5,
  level: 1
)
Quest.create!(
  title: "国字10",
  content: "<p>問題文をセットする</p>",
  genre: 5,
  level: 1
)
Quest.create!(
  title: "国字11",
  content: "<p>問題文をセットする</p>",
  genre: 5,
  level: 2
)
Quest.create!(
  title: "国字12",
  content: "<p>問題文をセットする</p>",
  genre: 5,
  level: 2
)
Quest.create!(
  title: "国字13",
  content: "<p>問題文をセットする</p>",
  genre: 5,
  level: 2
)
Quest.create!(
  title: "国字14",
  content: "<p>問題文をセットする</p>",
  genre: 5,
  level: 2
)
Quest.create!(
  title: "国字15",
  content: "<p>問題文をセットする</p>",
  genre: 5,
  level: 2
)
Quest.create!(
  title: "国字16",
  content: "<p>問題文をセットする</p>",
  genre: 5,
  level: 3
)
Quest.create!(
  title: "国字17",
  content: "<p>問題文をセットする</p>",
  genre: 5,
  level: 3
)
Quest.create!(
  title: "国字18",
  content: "<p>問題文をセットする</p>",
  genre: 5,
  level: 3
)
Quest.create!(
  title: "国字19",
  content: "<p>問題文をセットする</p>",
  genre: 5,
  level: 3
)
Quest.create!(
  title: "国字20",
  content: "<p>問題文をセットする</p>",
  genre: 5,
  level: 3
)
Quest.create!(
  title: "国字21",
  content: "<p>問題文をセットする</p>",
  genre: 5,
  level: 4
)
Quest.create!(
  title: "熟語と訓読み1",
  content: "<p>問題文をセットする</p>",
  genre: 6,
  level: 0
)
Quest.create!(
  title: "熟語と訓読み2",
  content: "<p>問題文をセットする</p>",
  genre: 6,
  level: 0
)
Quest.create!(
  title: "熟語と訓読み3",
  content: "<p>問題文をセットする</p>",
  genre: 6,
  level: 0
)
Quest.create!(
  title: "熟語と訓読み4",
  content: "<p>問題文をセットする</p>",
  genre: 6,
  level: 0
)
Quest.create!(
  title: "熟語と訓読み5",
  content: "<p>問題文をセットする</p>",
  genre: 6,
  level: 0
)
Quest.create!(
  title: "熟語と訓読み6",
  content: "<p>問題文をセットする</p>",
  genre: 6,
  level: 1
)
Quest.create!(
  title: "熟語と訓読み7",
  content: "<p>問題文をセットする</p>",
  genre: 6,
  level: 1
)
Quest.create!(
  title: "熟語と訓読み8",
  content: "<p>問題文をセットする</p>",
  genre: 6,
  level: 1
)
Quest.create!(
  title: "熟語と訓読み9",
  content: "<p>問題文をセットする</p>",
  genre: 6,
  level: 1
)
Quest.create!(
  title: "熟語と訓読み10",
  content: "<p>問題文をセットする</p>",
  genre: 6,
  level: 1
)
Quest.create!(
  title: "熟語と訓読み11",
  content: "<p>問題文をセットする</p>",
  genre: 6,
  level: 2
)
Quest.create!(
  title: "熟語と訓読み12",
  content: "<p>問題文をセットする</p>",
  genre: 6,
  level: 2
)
Quest.create!(
  title: "熟語と訓読み13",
  content: "<p>問題文をセットする</p>",
  genre: 6,
  level: 2
)
Quest.create!(
  title: "熟語と訓読み14",
  content: "<p>問題文をセットする</p>",
  genre: 6,
  level: 2
)
Quest.create!(
  title: "熟語と訓読み15",
  content: "<p>問題文をセットする</p>",
  genre: 6,
  level: 2
)
Quest.create!(
  title: "熟語と訓読み16",
  content: "<p>問題文をセットする</p>",
  genre: 6,
  level: 3
)
Quest.create!(
  title: "熟語と訓読み17",
  content: "<p>問題文をセットする</p>",
  genre: 6,
  level: 3
)
Quest.create!(
  title: "熟語と訓読み18",
  content: "<p>問題文をセットする</p>",
  genre: 6,
  level: 3
)
Quest.create!(
  title: "熟語と訓読み19",
  content: "<p>問題文をセットする</p>",
  genre: 6,
  level: 3
)
Quest.create!(
  title: "熟語と訓読み20",
  content: "<p>問題文をセットする</p>",
  genre: 6,
  level: 3
)
Quest.create!(
  title: "熟語と訓読み21",
  content: "<p>問題文をセットする</p>",
  genre: 6,
  level: 4
)
Quest.create!(
  title: "対義語・類義語1",
  content: "<p>問題文をセットする</p>",
  genre: 7,
  level: 0
)
Quest.create!(
  title: "対義語・類義語2",
  content: "<p>問題文をセットする</p>",
  genre: 7,
  level: 0
)
Quest.create!(
  title: "対義語・類義語3",
  content: "<p>問題文をセットする</p>",
  genre: 7,
  level: 0
)
Quest.create!(
  title: "対義語・類義語4",
  content: "<p>問題文をセットする</p>",
  genre: 7,
  level: 0
)
Quest.create!(
  title: "対義語・類義語5",
  content: "<p>問題文をセットする</p>",
  genre: 7,
  level: 0
)
Quest.create!(
  title: "対義語・類義語6",
  content: "<p>問題文をセットする</p>",
  genre: 7,
  level: 1
)
Quest.create!(
  title: "対義語・類義語7",
  content: "<p>問題文をセットする</p>",
  genre: 7,
  level: 1
)
Quest.create!(
  title: "対義語・類義語8",
  content: "<p>問題文をセットする</p>",
  genre: 7,
  level: 1
)
Quest.create!(
  title: "対義語・類義語9",
  content: "<p>問題文をセットする</p>",
  genre: 7,
  level: 1
)
Quest.create!(
  title: "対義語・類義語10",
  content: "<p>問題文をセットする</p>",
  genre: 7,
  level: 1
)
Quest.create!(
  title: "対義語・類義語11",
  content: "<p>問題文をセットする</p>",
  genre: 7,
  level: 2
)
Quest.create!(
  title: "対義語・類義語12",
  content: "<p>問題文をセットする</p>",
  genre: 7,
  level: 2
)
Quest.create!(
  title: "対義語・類義語13",
  content: "<p>問題文をセットする</p>",
  genre: 7,
  level: 2
)
Quest.create!(
  title: "対義語・類義語14",
  content: "<p>問題文をセットする</p>",
  genre: 7,
  level: 2
)
Quest.create!(
  title: "対義語・類義語15",
  content: "<p>問題文をセットする</p>",
  genre: 7,
  level: 2
)
Quest.create!(
  title: "対義語・類義語16",
  content: "<p>問題文をセットする</p>",
  genre: 7,
  level: 3
)
Quest.create!(
  title: "対義語・類義語17",
  content: "<p>問題文をセットする</p>",
  genre: 7,
  level: 3
)
Quest.create!(
  title: "対義語・類義語18",
  content: "<p>問題文をセットする</p>",
  genre: 7,
  level: 3
)
Quest.create!(
  title: "対義語・類義語19",
  content: "<p>問題文をセットする</p>",
  genre: 7,
  level: 3
)
Quest.create!(
  title: "対義語・類義語20",
  content: "<p>問題文をセットする</p>",
  genre: 7,
  level: 3
)
Quest.create!(
  title: "対義語・類義語21",
  content: "<p>問題文をセットする</p>",
  genre: 7,
  level: 4
)
Quest.create!(
  title: "テスト1",
  content: "<p>問題文をセットする</p>",
  genre: 8,
  level: 0
)
Quest.create!(
  title: "テスト2",
  content: "<p>問題文をセットする</p>",
  genre: 8,
  level: 1
)
Quest.create!(
  title: "テスト3",
  content: "<p>問題文をセットする</p>",
  genre: 8,
  level: 2
)
Quest.create!(
  title: "テスト4",
  content: "<p>問題文をセットする</p>",
  genre: 8,
  level: 3
)