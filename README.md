# README
# DB設計

## usersテーブル
|Column|Type|Options|
|------------|--------|-------|
|nickname    |string |null: false|
|email        |string |null: false, unique: true|
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

## itemsテーブル
|Column|Type|Options|
|------|----|-------|

|name          |string |null: false, limit:40|
|description   |text   |null: false, limit:1000|
|category_id   |integer|null: false|
|condition     |string|
|ship_charge|string|null: false|
|ship_area_id  |integer |null: false|
|ship_date_id  |integer |null: false|
|ship_method_id|integer |null: false|
|price         |integer|null: false|
|user          |references|null: false, foreign_key: true|

### Assosiation
- belongs_to :user
- belongs_to :category
- has_many :comments
- has_many :images
- has_one :condition
- has_many :purchase_history


## addressテーブル
|Column|Type|Options|
|------|----|-------|
|postal_code   |string |null: false|
|prefecture_id   |integer |null: false|
|city_id  |integer|null: false|
|street    |string|null: false|
|building   |string|null: false|
|phone_number  |string|null: false|
|purchase_history|references |null: false, foreign_key: true |

### Assosiation
-has_one :purchase_history

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
|item   |references|null: false, foreign_key: true|
|address  |references|null: false, foreign_key: true|

### Assosiation
- belongs_to :user
- belongs_to :item
- belongs_to :address
