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
|first_name_kana  |string |null: false|
|last_name_kana  |string |null: false|
|birthday    |date   |null: false|

### Assosiation
- has_many :items
- has_many :comments
- has_many :orders

## itemsテーブル
|Column|Type|Options|
|------|----|-------|

|name          |string |null: false|
|description   |text   |null: false|
|category_id   |integer|null: false|
|condition_id  |integer |null: false|
|ship_area_id  |integer |null: false|
|ship_date_id  |integer |null: false|
|ship_method_id|integer |null: false|
|price         |integer|null: false|
|user          |references|null: false, foreign_key: true|

### Assosiation
- belongs_to :user
- belongs_to :category
- has_many :comments
- has_one :order


## addressesテーブル
|Column|Type|Options|
|------|----|-------|
|postal_code   |string |null: false|
|ship_area_id  |integer |null: false|
|city  |string|null: false|
|street    |string|null: false|
|building   |string|
|phone_number  |string|null: false|
|order|references |null: false, foreign_key: true |

### Assosiation
-belongs_to :purchase_history

## commentsテーブル
|Column|Type|Options|
|------|----|-------|
|text|text      |null: false|
|user|references|null: false, foreign_key: true|
|item|references|null: false, foreign_key: true|

### Assosiation
- belongs_to :user
- belongs_to :item

## categoriesテーブル
|Column|Type|Options|
|------|----|-------|
|name    |string|null: false|
|ancestry|text  |null: false|

### Assosiation
- has_many :items

## ordersテーブル
|Column|Type|Options|
|------|----|-------|
|user   |references|null: false, foreign_key: true|
|item   |references|null: false, foreign_key: true|

### Assosiation
- belongs_to :user
- belongs_to :item
- has_one :address
