# README

## userテーブル
|Column|Type|Options|
|------|----|-------|
|id|integer|null: false|
|name|string|null: false|
|email|string|null: false|
|password|string|null: false|
|first_name|string|null: false|
|last_name|string|null: false|
|first_name_kana|string|null: false|
|last_name_kana|string|null: false|
|birthday|string|null: false|
|tel_number|integer|null: false|
|profile|string||

### Association
- has_many :sns_credentials, dependent: :destroy
- has_one :credit_card
- has_one :delivery

#### メモ
- uniqueキー :tel_number, email


## credit_cardテーブル
|Column|Type|Options|
|------|----|-------|
|id|integer|null: false|
|user_id|integer|null: false|
|cutomer_id|integer|null: false|
|card_id|integer|null: false|

### Association
- belongs_to :user


## sns_credentialテーブル
|Column|Type|Options|
|------|----|-------|
|id|integer|null: false|
|user_id|integer|null: false|
|provider|string|null: false|
|uid|string|null: false|

### Association
- belongs_to :user


## tradingテーブル
|Column|Type|Options|
|------|----|-------|
|id|integer|null: false|
|item_id|integer|null: false, foreign_key: true|
|saler_id|integer|null: false|
|buyer_id|integer||
|sall_state|string|null: false|
|buy_date|datetime||
|delivery_id|integer||

### Association
- belongs_to :item


## deliveryテーブル
|Column|Type|Options|
|------|----|-------|
|id|integer|null: false|
|user_id|integer|null: false, foreign_key: true|
|postal_code|integer|null: false|
|area|string|null: false|
|city|string|null: false|
|address|string|null: false|
|building|string||
|first_name|string|null: false|
|last_name|string|null: false|
|first_name_kana|string|null: false|
|last_name_kana|string|null: false|

### Association
- belongs_to :user


## itemテーブル
|Column|Type|Options|
|------|----|-------|
|id|integer|null: false|
|item_name|string|null: false|
|description|string|null: false|
|state|string|null: false|
|price|integer|null: false|
|size|string|null: false|
|region|string|null: false|
|fee_size|string|null: false|
|delivery_date|string|null: false|
|category_index|integer|null: false|
|goods_count|integer||

### Association
- has_many :images, dependent: :destroy
- has_many :goods, dependent: :destroy
- has_one :trading, dependent: :destroy
- has_one :categories


## imageテーブル
|Column|Type|Options|
|------|----|-------|
|id|integer|null: false|
|item_id|integer|null: false, foreign_key: true|
|url|string|null: false|

### Association
- belongs_to :item


## categoryテーブル
|Column|Type|Options|
|------|----|-------|
|id|integer|null: false|
|name|string|null: false|
|ancenstry|integer|null: false|

### Association
- has_many :items
- has_ancestry


## goodテーブル
|Column|Type|Options|
|------|----|-------|
|id|integer|null: false|
|user_id|integer|null: false|
|item_id|integer|null: false|

### Association
- belongs_to :item, counter_cache: :goods_count
- belongs_to :user