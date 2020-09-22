# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

# Name
 
furima

アプリ「furima」は、ユーザーが商品を売買できるフリーマーケットのアプリケーションです。
 
# URL	
https://furima-28710.herokuapp.com/

# テスト用アカウント
	Basic認証 
	ID : admin
	Pass : 2222

	テスト用アカウント等
  購入者用
  メールアドレス: furimi@gmail.com
  パスワード: furimi0000
  購入用カード情報
  番号：4242424242424242
  期限：Mon Mar 23 2020 00:00:00 GMT+0900 (日本標準時)
  セキュリティコード：123
  出品者用
  メールアドレス名: furiru@gmail.com
  パスワード: furiru0000

# 開発状況
  開発環境
  Ruby/Ruby on Rails/MySQL/Github/AWS/Visual Studio Code
  開発期間と平均作業時間
  開発期間：8/17~9/9(23日間）
  1日あたりの平均作業時間：10
  合計：230時間程度

# Usage	
ユーザーは検索機能からお好きな曲を検索していただくことで、元ネタとなったサンプリング曲やコラボアーティストとの関係性、制作のプロセスなどの考察や解説を通して音楽をより深く知ることができます。
解説や歌詞はユーザーが投稿・編集することができます。また、その曲及び注釈に対し、コメントすることができる欄を作りました。アーティスト及び、プロデューサーのマイページも用意されており、こちらもユーザーがバイオグラフィー、snsアカウントなどを編集していただけます。
お問い合わせフォームを通して、コメントや注釈の削除依頼を出すことができます。

# 目指した課題解決	
アプリケーションの課題と解決策
以下のシートをご覧ください。アプリケーションのペルソナが持つ課題を洗い出し、そして解決策となる追加実装の仕様を洗い出しました。

https://docs.google.com/spreadsheets/d/11ZtSWJ_xAGVq_cqR1fn2jDb7fb-p973Zk5Dfcksv-po/edit#gid=282075926

CtoCサービスであるにも拘らず、取引相手のユーザーの顔が見えづらいことが大きな問題点と考え、マイページとコメント機能を実装しました。次に、目的の商品を探しやすくすることで、サイト利用の活発化を図るため、検索機能とタグ機能を実装しました。また、同様の記述を幾度も行わなければならない仕様を改善し、ユーザーのストレス軽減を目的として、その他の機能を実装しました。

# 洗い出した要件	
洗い出した課題の中から、マイページとコメント機能、検索機能とタグ機能、snsでの新規登録/ログイン機能、購入に使用するクレジットカードと配送先住所の登録機能、エラーメッセージの日本語化、画像をs3に保存する機能について追加実装を行いました。それぞれの仕様を紹介します。

# 実装した機能についての説明

マイページ機能

ログインした状態で、こちらのURL（https://furima-28710.herokuapp.com/users/1）にアクセスするとご覧いただけます。他ユーザのマイページにアクセスすると、そのユーザーがこれまでに出品してきた商品や、自己紹介を確認することができます。このページは、商品出品ページにおける「出品者」のボタンやコメント者の名前をクリックすると見ることができます。
この機能によって、「取引可能なユーザーであるかどうか」を判断する材料が増えます。
実装にあたって工夫した点は、ログインしているユーザー自身のページである場合には、「ユーザー情報編集へ」のボタンを押すことができ、名前、メールアドレス、パスワードの変更、及びクレジットカード機能の登録ができるようにした点です。また各ページのcssを統一し、シンプルな設計であることを意識しました。


コメント機能

こちらのURL（https://furima-28710.herokuapp.com/items/1）にアクセスするとご覧いただけます。
ログインユーザーは、商品の詳細ページよりコメントを残すことが可能です。
この機能によって、ユーザー「どのような商品であるか」を判断する材料が増えます。
実装にあたって工夫した点は、コメント後のページ遷移先を指定の商品詳細ページにすることでユーザーがストレス少なく操作することができます。また非同期通信であるため、ページをリロードすることなくチャットするよウナ気軽さでお使いいただけます。


検索機能

トップページなどのヘッダー上の検索フォームから「非常食」と検索していただけるとご確認いただけます。
ユーザーは、関連するキーワードを使って商品を調べることが可能です。
この機能によって、「購入したい商品が存在するか」「関連商品同士の比較」をする材料が増えます。
実装にあたって工夫した点は、商品名、商品説明、タグ名のいずれかにキーワードが当てはまった商品を全て検索結果に表示させる機能の実装です。これによって、もし、商品名にキーワードがなくとも、ハッシュタグ名とキーワードが被る商品なども検索することができ、拾える商品の範囲を大きくしました。


タグ機能
こちらのURL（https://furima-28710.herokuapp.com/items/41）にアクセスし、ハッシュタグ「#食べ物」をクリックしていただけるとご覧いただけます。
商品詳細ページから、投稿されているハッシュタグをクリックすると、同様のハッシュタグを持った商品の一覧が確認できます。
この機能によって、「関連商品同士の比較」をする材料が増えます。
実装にあたって工夫した点は、検索機能と似たのhtml/cssを用いることで、シンプルで見やすいビューを意識した点です。この機能によって、気になる商品を購入しようか悩んでいる際に、わざわざ検索フォームからキーワードを入力することなく、ユーザーが関連商品を探すことができるようになります。

snsでの新規登録/ログイン機能

こちらのURL（https://furima-28710.herokuapp.com/users/sign_up）にアクセスし、「facebookで登録」もしくは「googleで登録」をクリックしていただきますと、ご登録済みのsnsで使用している名前とメールアドレスがフォームに記入されている状態で新規登録の手続きを進めることができます。
また、こちらのURL（https://furima-28710.herokuapp.com/users/sign_in）にアクセスし、「facebookで登録」もしくは「googleで登録」をクリックしていただきますと、SNSで認証されたユーザーが、すでにアプリケーションに登録されているユーザーである場合、メールアドレスやパスワードの記述をすることなくログインしていただけます。
この機能によって、ユーザーの登録が簡易的な仕様になります。
実装にあたって工夫した点は、deviseのデフォルトのhtmlを壊さないようにビューを追記した点です。また、Facebook for Developersは本番環境で実装する際は、認証後のリダイレクト先uriを登録しなければならない点に気をつけました。

クレジットカードの登録
ログイン後、ログインユーザーのマイページにアクセスし、「ユーザー情報編集へ」ボタンをクリック→「カード登録へ」ボタンをクリックすると購入に使用するクレジットカードを登録できます。
カード登録を済ませたユーザーは、商品を購入する際に、カード情報の記入をすることなく、購入を実行することができます。また、登録されたカード情報はご本人のみ、ユーザー情報編集ページから確認できます。
この機能によって、ユーザーの商品購入が簡易的な仕様になります。
実装にあたって工夫した点は、シンプルで統一されたhtmlの作成です。また、新規登録時に登録しなければならない情報が増えすぎる事態を防ぐために、登録を任意制にしました。カードを登録しないユーザーは、購入のたびにフォームに情報を記述できるように条件分岐をつけました。

配送先住所の登録機能

こちらのURL（https://furima-28710.herokuapp.com/users/sign_up）にアクセスし、
フォームに情報を入力した後、「次へ」のボタンをクリックしていただくと、配送先住所のフォームに遷移します。
このウィザード機能の仕様によって、1ページで縦長に全ての情報を登録するよりも、どの情報を、どのページで登録しているのか分かるので、ユーザーにとって見やすいサイトになります。
配送先住所を事前に登録することで、商品を購入する際に、配送先住所を記述する手間がなくなりました。
購入ページでは以下のように、配送先が確認できます。
新規登録時に、登録する情報が増えすぎてしまう事態を危惧したため、カード情報か住所情報のどちらかを任意登録にしようと考えました。クレジットカードを暗記している人は、住所を暗記しているよりも少ないと推測したため、住所情報のみを新規登録時に登録させる仕様にしました。

エラーメッセージの日本語化

こちらのURL（https://furima-28710.herokuapp.com/users/sign_up）にアクセスし、フォームの値を空のまま「次へ」のボタンを押すとご覧いただけます。
この機能によって、日本語を母語とするユーザーにとって、エラー情報が読み取りやすくなります。
同様に、ログイン、新規登録、出品投稿、購入の際にバリデーションに引っかかるとを日本語でエラーメッセージが表示されます。


# 動作確認方法
WebブラウザGoogle Chromeの最新版を利用してアクセスしてください。
ただしデプロイ等で接続できないタイミングもございます。その際は少し時間をおいてから接続してください。
接続先およびログイン情報については、上記の通りです。
同時に複数の方がログインしている場合に、ログインできない可能性があります。
テストアカウントでログイン→トップページから出品ボタン押下→商品情報入力→商品出品
確認後、ログアウト処理をお願いします。

* ...
## users テーブル
|     Column       |  Type    |   Options   |
| ---------------- | -------- | ----------- |
|      email       | string   | null: false |
|encrypted_password| string   | null: false |
|    nickname      | string   | null: false |
|    given_name    | string   | null: false |
|   family_name    | string   | null: false |
|  read_fam_name   | string   | null: false |
|  read_given_name | string   | null: false |
|    birthday      | datetime | null: false |
### Association
- has_many :items
- has_many :orders
- has_many :comments
- has_one :card, dependent: :destroy
- has_one :profiles
- has_many :sns_credentials
## items テーブル

|       Column             |  Type      | Options                        |
| ------------------------ | ---------- | ------------------------------ |
|        image             |   string   | null: false                    |
|        name              |   string   | null: false                    |
|     description          |    text    | null: false                    |
|         price            |  integer   | null: false                    |
|         user             | references | null: false, foreign_key: true |
|      category_id         |   integer  | null: false                    |
|     condition_id         |   integer  | null: false                    |
| shipping_fee_person_id   |   integer  | null: false                    |
|       date_ish_id        |   integer  | null: false                    |
|        region_id         |   integer  | null: false                    |
### Association

- belongs_to :user
- has_one :order
- has_one_attached :image
- has_many :comments
- has_many :item_tag_relations
- has_many :tags, through: :item_tag_relations
## orders テーブル

| Column | Type       | Options                        |
| ------ | ---------- | ------------------------------ |
| user   | references | null: false, foreign_key: true |
| item   | references | null: false, foreign_key: true |
### Association

- belongs_to :item
- belongs_to :user
- has_one :address

## addresses テーブル

| Column       | Type       | Options                        |
| ------------ | ---------- | ------------------------------ |
| postal_code  | string     | null: false                    |
| prefecture_id   | integer    | null: false                    |
| city         | string     | null: false                    |
| street       | string     | null: false                    |
| building     | string     |                                |
| phone_number | string     | null: false                    |
| order        | references | null: false, foreign_key: true |
### Association

- belongs_to :order

## comments テーブル

| Column | Type       | Options                        |
| ------ | ---------- | ------------------------------ |
| user   | references | null: false, foreign_key: true |
| item   | references | null: false, foreign_key: true |
### Association

- belongs_to :item
- belongs_to :user

## tags テーブル

| Column   | Type       | Option     |
| -------- | ---------- | ---------- |
| tag_name |   string   | null:false |
### Association

- has_many :item_tag_relations
- has_many :items, through: :item_tag_relations

## item_tag_relations テーブル

| Column | Type       | Options                        |
| ------ | ---------- | ------------------------------ |
| item_id| references | null: false, foreign_key: true |
| tag_id | references | null: false, foreign_key: true |
### Association

- belongs_to : item
- belongs_to : tag

## cards テーブル

| Column         | Type       | Options                        |
| -------------- | ---------- | ------------------------------ |
| card_token     | string     | null: false                    |
| customer_token | string     | null: false                    |
| user           | references | null: false, foreign_key: true |
### Association

- belongs_to :user

## profiles テーブル

| Column           | Type     | Option                         |
| -------------- | ---------- | ------------------------------ |
| text           |   text     |                                |
| user           | references | null: false, foreign_key: true |
### Association

- belongs_to :user

## sns_credentials テーブル

| Column           | Type     | Option                         |
| -------------- | ---------- | ------------------------------ |
| provider       |   string   |                                |
| uid            |   string   |                                |
| user           | references | null: false, foreign_key: true |
### Association

- belongs_to :user