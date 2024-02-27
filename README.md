# README
# DB設計

## usersテーブル
|Column|Type|Options|
|------------|--------|-------|
|nickname    |string |null: false|
|mail        |string |null: false|
|password    |string |null: false|
|encrypted_password    |string |null: false|
|first_name  |string |null: false|
|last_name   |string |null: false|
|first_kana  |string |null: false|
|first_kana  |string |null: false|
|birth_year  |integer|null: false|
|birth_month |integer|null: false|
|birth_day   |integer|null: false|

### Assosiation
- has_many :cards
- has_many :items
- has_many :comments

## cardsテーブル
|Column|Type|Options|
|------|----|-------|
|user_id    |integer|null: false, foreign_key: true|
|limit_month|integer|null: false|
|limit_year |integer|null: false|
|security   |integer|null: false|

### Assosiation
- belongs_to :user

## itemsテーブル
|Column|Type|Options|
|------|----|-------|
|image_id      |integer|null: false, foreign_key: true|
|name          |string |null: false, limit:40|
|description   |text   |null: false, limit:1000|
|category_id   |integer|null: false, foreign_key: true|
|condition     |string|
|ship_charge   |string|null: false|
|ship_area     |string|null: false|
|ship_date     |string|null: false|
|ship_method   |string|null: false|
|price         |integer|null: false, foreign_key: true|
|user_id       |integer|null: false, foreign_key: true|

### Assosiation
- belongs_to :user
- belongs_to :category
- has_many :comments
- has_many :images
- has_one :condition

## commentsテーブル
|Column|Type|Options|
|------|----|-------|
|text|text      |null: false|
|user|references|null: false, foreign_key: true|
|item|references|null: false, foreign_key: true|

### Assosiation
- belongs_to :user
- belongs_to :item

## conditionテーブル
|Column|Type|Options|
|------|----|-------|
|name   |string |null: false|
|item_id|integer|null: false, foreign_key: true|

### Assosiation
- belongs_to :item

## categoryテーブル
|Column|Type|Options|
|------|----|-------|
|name    |string|null: false|
|ancestry|text  |null: false|

### Assosiation
- has_many :items

## imagesテーブル
|Column|Type|Options|
|------|----|-------|
|image   |text   |null: false|
|image_id|integer|null: false, foreign_key: true|

### Assosiation
- belongs_to :item
