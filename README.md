# アプリケーション名

kanken-1-monpi (漢検１級門扉)

# アプリケーション概要（このアプリでできること）

ユーザーは登録された記事(テキスト)を参考に、そのテキストに結びつけられた４択の問題を解き、正誤判定によるスコアを取得することができます。
閲覧できる記事および挑戦できる問題の数は、総合スコアによって判定されるユーザーのランクによって変わります。

# URL

# テスト用アカウント

# 利用方法

順序１：まずはユーザーアカウントを作成してください。ニックネーム、メールアドレス、パスワードの登録が必要です。
順序２：テキスト一覧がジャンルごとに表示されるので、お好きなテキストを選んでください。
順序３：「問題を解く」ボタンをクリックすると、そのテキストの内容から問題が出題されます。全て４択形式となっているので、選んだ上で最下のボタンをクリックしてください。すると答え合わせが始まります。再度ボタンをクリックすることで、トップページに戻ります。
順序４：蓄積されたスコアが一定以上に達する、総合テストにおいて一定以上のスコアを獲得する、などの条件によってユーザーのランクが上昇することがあります。ランクアップすると、閲覧できるテキスト・問題が増えます。

# 目指した課題解決

このアプリケーションは、デジタル環境において漢検１級の検定資格を学習するための基台を獲得することに主軸を置いて制作されました。
多くの日本人にとっても漢検１級にて出題される漢字は殆ど全てが未知の言語です。よって普段の読書のように、あるいは他の資格学習のようにスラスラと内容を把握するリーディング学習とは別の次元です。文字そのものを覚えなければいけないので、書く作業、辞典を開く作業は避けて通れないでしょう。
そういった未知要素があまりに多すぎるが故に、勉強方法が分からずリタイアする関心者も多い模様です。よって本アプリでは、本格的な学習を始める手前のフェーズの代わりとして、文字そのものに対する対する既知感を手軽な感覚で養うことを最大目的といたしました。
日常的に移動が多く、まとまった時間が持てない充実した日々を送る関心者がスマートフォンと数分あれば漢検１級の内容に目を通せるよう、モバイルフレンドリーで４択問題という手軽を追求したインプット/アウトプットを意識。手軽な隙間学習を繰り返すことによりデジャブを蓄積し、書き取りなど本気の学習を決意し、また挫折しないための事前の素養を獲得できると信じております。

# 洗い出した要件

# 実装した機能についての画像やGIFおよびその説明

# 実装予定の機能

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
| nickname           | string |                           |


## articles テーブル

| Column             | Type     | Options          |
| ------------------ | -------- | ---------------- |
| title              | string   | null: false      |
| content            | text     | null: false      |
| genre_id           | integer  | null: false      |
| rank_id            | integer  | null: false      |

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
| rank_id  | integer | null: false      |

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
| repeat | integer    |                                |

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


# ローカルでの動作方法

