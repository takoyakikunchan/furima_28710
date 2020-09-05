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