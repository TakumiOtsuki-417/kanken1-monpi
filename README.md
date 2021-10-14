# アプリケーション名

kanken-1-monpi (漢検１級門扉)

# アプリケーション概要（このアプリでできること）

ユーザーは登録された記事(テキスト)を参考に、そのテキストに結びつけられた４択の問題を解き、正誤判定によるスコアを取得することができます。
閲覧できる記事および挑戦できる問題の数は、総合スコアによって判定されるユーザーのランクによって変わります。

# URL
https://kanken1-monpi.herokuapp.com/

# テスト用アカウント

## ユーザーアカウント
test2@test.com
test6000

## 管理者アカウント
test@test.com
test6000

# 利用方法

1. まずはユーザーアカウントを作成してください。ニックネーム、メールアドレス、パスワードの登録が必要です。
2. テキスト一覧がジャンルごとに表示されるので、お好きなテキストを選んでください。
3. 「問題を解く」ボタンをクリックすると、そのテキストの内容から問題が出題されます。全て４択形式となっているので、選んだ上で最下のボタンをクリックしてください。すると答え合わせが始まります。再度ボタンをクリックすることで、トップページに戻ります。
4. 蓄積されたスコアが一定以上に達する、総合テストにおいて一定以上のスコアを獲得する、などの条件によってユーザーのランクが上昇することがあります。ランクアップすると、閲覧できるテキスト・問題が増えます。

# 目指した課題解決

このアプリケーションは、デジタル環境において漢検１級の検定資格を学習するための基台を獲得することに主軸を置いて制作されました。

多くの日本人にとっても漢検１級にて出題される漢字は殆ど全てが未知の言語です。よって普段の読書のように、あるいは他の資格学習のようにスラスラと内容を把握するリーディング学習とは別の次元です。文字そのものを覚えなければいけないので、書く作業、辞典を開く作業は避けて通れないでしょう。

そういった未知要素があまりに多すぎるが故に、勉強方法が分からずリタイアする関心者も多い模様です。よって本アプリでは、本格的な学習を始める手前のフェーズの代わりとして、文字そのものに対する対する既知感を手軽な感覚で養うことを最大目的といたしました。

日常的に移動が多く、まとまった時間が持てない充実した日々を送る関心者がスマートフォンと数分あれば漢検１級の内容に目を通せるよう、モバイルフレンドリーで４択問題という手軽を追求したインプット/アウトプットを意識。手軽な隙間学習を繰り返すことによりデジャブを蓄積し、書き取りなど本気の学習を決意し、また挫折しないための事前の素養を獲得できると信じております。

# 洗い出した要件

- 管理者アカウント機能
- ユーザーアカウント機能
- 記事管理機能(管理者)
- 問題管理機能(管理者)
- 記事問題セット機能(管理者)
- 記事閲覧機能(ユーザー)
- 問題回答機能(ユーザー)
- スコア保存機能(ユーザー)
- 称号更新機能(ユーザー)

# 実装した機能についての説明

## 管理者アカウント機能

ユーザー(user)とは別に管理者用(admin)アカウント機能を実装する。Deviseにて実装。

誰でも管理者に登録できてしまうとコンテンツ整理が利かなくなるため、基本的にはユーザーより登録・ログインが難しいように工夫する。

具体的には登録・ログインの際に環境変数にて定義している文字列の記入を必須とする。

## ユーザーアカウント機能

ユーザーアカウント機能をDeviseにて実装する。

nickname、email、passwordを入力させ、初期値0としたrank_idを含めて登録する。

## 記事管理機能(管理者)

管理者は、教科書テキストにあたる記事を作成・編集・削除できるようにする。ユーザーは、その記事を閲覧できるようにする。

タイトル(title)、内容(content)、記事ジャンル(genre_id)、記事ランク(rank_id)をフォームにて入力し送信する。genre_idとrank_idはActiveHashを用いて問題管理機能と入力項目を使い回す。

また、管理者あるいはユーザーのいずれにもログインしていない場合は強制的にユーザーログインページへ遷移する。


## 問題管理機能(管理者)

本アプリケーションの核ともいえる、４択問題を作成・編集・削除する機能。管理者が利用でき、ユーザーには全く権限がない。

問いの文章(question)、４つの選択肢(selectX)、正解(answer)、解説(explain)、問題ジャンル(genre_id)、問題ランク(rank_id)を設定する。ジャンルとランクはActiveHashを利用し、記事との連動に使う。

全て必須項目であるのに加え、選択肢のうち１つは必ず正解の文字列と一致してなければデータベースに保存ができないようにする。

## 記事問題セット機能(管理者)

記事(Article)と問題(Quest)を紐付ける中間テーブル実装。これにより記事ページにネストされた問題を解かせるという導線を作る。

管理者側で必要なアクションはindex/new/create/destroyのみとし、記事と問題とを紐付ける(以後、問題をセットする等と表現)。セットできる問題は記事レベル以下かつ記事ジャンルと同等の設定のもののみ。destroyアクションへのリンクを設定し、気軽にセット解除できるようにもする。

## 記事閲覧機能(ユーザー)

一覧表示画面では、ユーザーの場合は自身の登録されているランク以下の記事ランクに設定されている記事がジャンル毎に表示される。

詳細表示画面には記事に紐づけられた問題を一覧表示する挑戦ページへのリンクを貼る。

また、管理者あるいはユーザーのいずれにもログインしていない場合は強制的にユーザーログインページへ遷移する。

## 問題回答機能(ユーザー)

記事問題セット機能とコントローラーやビューは共有するが、ユーザー側で必要なアクションはindex/create/updateのみとし、ビューやコントローラーの処理は管理者側と条件分岐させていく。

問題一覧ページにて問題を解かせ、全ての問題で選択肢(ラジオボタン)をチェックすることで「答え合わせ」のボタンを表示。Javascriptで非表示にしていた答えと解説を一斉表示すると同時に未選択のラジオボタンにdisabled属性追加。更に「回答送信」のボタンをクリックすることで、フォームのデータをスコア更新機能へと回す。

## スコア保存機能(ユーザー)

ユーザー側がセットされた問題を回答し送信することで、問題に設定されている正解カラムの文字列と選択ラジオボタンのvalueを比較、その記事とユーザーとの間に得点率を記録する(create/update)。つまりは中間テーブルの実装で、得点率(score)を同時に保存する。

苦手問題記録やユーザーランク更新を同時に行うため、Formオブジェクトパターンを実装し一括化する。

updateアクションだった場合は得点率が前回よりも上回っていた場合にのみ更新を行う。

## 称号更新機能(ユーザー)

回答データが送信されたタイミングで処理に入る(create/update)。

得点率の計算・更新判断をした後に記事-ユーザー間の中間テーブルから該当ユーザーに関する全てのscoreデータを取得し、その合計値を計算。また、「テスト」ジャンルである記事IDで更に絞り込み、その各得点率が一定水準以上か否かでテストの合格数を計算。

「合格数が〇である」かつ「合計得点率が〇〇以上」という条件のcase文を用いて、ユーザーランク(rank_id)を昇格させるかどうかを判断する。
この１連の処理は得点率の更新が判断された場合のみに行うとし、またランクの降格は実装しないものとする。

# 実装予定の機能

- 不正解問題記録機能(ユーザー)

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


# ローカルでの動作方法

## 動作環境

Rubyバージョン: 2.6.5
Railsバージョン: 6.0.0

## コード一式のCLIダウンロードの流れ

1. 複製物を入れるディレクトリに移動して、以下のコマンド

- git clone https://github.com/TakumiOtsuki-417/kanken1-monpi.git

2. 複製物へとカレントディレクトリを移動させてから以下のコマンド

- bundle install
- yarn install

## 注意事項

- application_controller.rb
- admin.rb(モデル、テストファイル)
- seed.rb(初期データ)

これらのコードの中に「環境変数」が定義されています。

初期データを入れる場合、また管理者ログインをする前に必ずこちらの環境変数を通常の変数や値に変更してください。

