# テーブル設計

## users テーブル

| Column             | Type    | Options                   |
| ------------------ | ------- | ------------------------- |
| email              | string  | null: false, unique: true |
| encrypted_password | string  | null: false               |
| nickname           | string  | null: false               |
| rank_id            | integer | null: false               |

### Association

- has_many :scores
- has_many :user_quests
- has_many :articles, through: :score
- has_many :quests, through: :user_quest

### Association (ActiveHash)

- belongs_to :rank

## admins テーブル

| Column             | Type   | Options                   |
| ------------------ | ------ | ------------------------- |
| email              | string | null: false, unique: true |
| encrypted_password | string | null: false               |
| nickname           | string | null: false               |


## articles テーブル

| Column             | Type     | Options          |
| ------------------ | -------- | ---------------- |
| title              | string   | null: false      |
| content            | text     | null: false      |
| genre_id           | integer  | null: false      |
| level_id           | integer  | null: false      |

### Association

- has_many :article_quests
- has_many :quests, through: :article_quest
- has_many :scores
- has_many :user, through: :score

### Association (ActiveHash)

- belongs_to :genre
- belongs_to :level

## quests テーブル

| Column   | Type    | Options          |
| -------- | ------- | ---------------- |
| question | string  | null: false      |
| select1  | text    | null: false      |
| select2  | text    | null: false      |
| select3  | text    | null: false      |
| select4  | text    | null: false      |
| answer   | text    | null: false      |
| explain  | text    | null: false      |
| genre_id | integer | null: false      |
| level_id | integer | null: false      |

### Association

- has_many :user_quests
- has_many :user, through: :user_quest

### Association (ActiveHash)

- belongs_to :genre
- belongs_to :level

## article_quests テーブル

| Column  | Type       | Options                        |
| ------- | ---------- | ------------------------------ |
| article | references | null: false, foreign_key: true |
| quest   | references | null: false, foreign_key: true |

### Association

- belongs_to :article
- belongs_to :quest

## user_quests テーブル

| Column | Type       | Options                        |
| ------ | ---------- | ------------------------------ |
| user   | references | null: false, foreign_key: true |
| quest  | references | null: false, foreign_key: true |
| repeat | integer    | null: false                    |

### Association

- belongs_to :user
- belongs_to :quest

## scores テーブル

| Column   | Type       | Options                        |
| -------- | ---------- | ------------------------------ |
| user     | references | null: false, foreign_key: true |
| article  | references | null: false, foreign_key: true |
| score    | integer    | null: false                    |

### Association

- belongs_to :user
- belongs_to :article
