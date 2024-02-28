# README
# DB設計

## usersテーブル
|Column|Type|Options|
|------------|--------|-------|
|nickname    |string |null: false|
|mail        |string |null: false, default: ""|
|encrypted_password    |string |null: false|
|first_name  |string |null: false|
|last_name   |string |null: false|
|first_kana  |string |null: false|
|first_kana  |string |null: false|
|birthday    |date   |null: false|

### Assosiation

- has_many :items
- has_many :comments
- has_many :purchase_history
- has_one :address

## itemsテーブル
|Column|Type|Options|
|------|----|-------|

|name          |string |null: false, limit:40|
|description   |text   |null: false, limit:1000|
|category_id   |integer|null: false, foreign_key: true|
|condition     |string|
|ship_charge   |string|null: false|
|ship_area_id  |integer |null: false, foreign_key: true |
|ship_date_id  |integer |null: false, foreign_key: true |
|ship_method_id|integer |null: false, foreign_key: true |
|price         |integer|null: false, foreign_key: true|
|user          |references|null: false, foreign_key: true|

### Assosiation
- belongs_to :user
- belongs_to :category
- has_many :comments
- has_many :images
- has_one :condition


## addressテーブル
|Column|Type|Options|
|------|----|-------|
|postal_code   |string |null: false|
|prefecture_id   |integer |null: false|
|city_id  |integer|null: false|
|street    |string|null: false|
|building   |string|null: false|
|phone_number  |string|null: false, foreign_key: true |
|purchase  |references |null: false, foreign_key: true |

### Assosiation
- belongs_to :user

## commentsテーブル
|Column|Type|Options|
|------|----|-------|
|text|text      |null: false|
|user|references|null: false, foreign_key: true|
|item|references|null: false, foreign_key: true|

### Assosiation
- belongs_to :user
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

## purchase_historyテーブル
|Column|Type|Options|
|------|----|-------|
|user   |references|null: false, foreign_key: true|
|product|references|null: false, foreign_key: true|

### Assosiation
- belongs_to :user