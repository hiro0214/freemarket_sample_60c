# README


## userテーブル
|Column|Type|Options|
|------|----|-------|
|id|integer|null: false|
|nickname|string|null: false|
|email|string|null: false|
|password|string|null: false|
|first_name|string|null: false|
|last_name|string|null: false|
|first_name_kana|string|null: false|
|last_name_kana|string|null: false|
|gender|string|null: false|
|birthday|string|null: false|
|tel_number|integer|null: false|
|profile|string|   |
|avatar|string|   |

### Association
- has_many :reviews
- has_many :tradings
- has_many :comments, through: :user_comments
- has_one :credit_card
- has_one :user_address

#### メモ
- uniqueキー :tel_number, credit_card_id



## user_addressテーブル
|Column|Type|Options|
|------|----|-------|
|user_id|integer|null: false, foreign_key: true|
|postal_code|integer|null: false|
|area|string|null: false|
|city|string|null: false|
|address|string|null: false|
|building|string|   |


### Association
- belongs_to :user



## reviewテーブル
|Column|Type|Options|
|------|----|-------|
|id|integer|null: false|
|user_id|integer|null: false, foreign_key: true|
|point|integer|   |

### Association
- belongs_to :user



## credit_cardテーブル
|Column|Type|Options|
|------|----|-------|
|id|integer|null: false|
|user_id|integer|null: false, foreign_key: true|
|card_name|string|null: false|
|number|integer|null: false|
|pin|integer|null: false|
|company|string|null: false|

### Association
- belongs_to :user


#### メモ
- uniqueキー :card_name, number


## tradingテーブル
|Column|Type|Options|
|------|----|-------|
|id|integer|null: false|
|sall_state|string|null: false|
|buyer_id|integer||
|saller_id|integer|null: false|
|item_id|integer|null: false, foreign_key: true|


### Association
- has_many :users
- has_one :items



## itemテーブル
|Column|Type|Options|
|------|----|-------|
|id|integer|null: false|
|buyer_id|integer|foreign_key: true|
|saller_id|integer|foreign_key: true|
|name|string|null: false|
|description|string|null: false|
|state|string|null: false|
|price|integer|null: false|
|like|string|   |
|size|string|null: false|
|fee_size|string|null: false|
|region|string|null: false|
|date|integer|null: false|


### Association
- belongs_to :brand
- belongs_to :category
- has_many :comments , dependent: :delete
- has_many :shippings, dependent: :delete
- has_many :images, dependent: :delete
- has_one :trading



## commentテーブル
|Column|Type|Options|
|------|----|-------|
|id|integer|null: false|
|text|string|   |
|item_id|integer|null: false, foreign_key: true|
|users_comments_id|integer|null: false, foreign_key: true|


### Association
- belongs_to :item
- belongs_to :user



## user_commentテーブル
|Column|Type|Options|
|------|----|-------|
|id|integer|null: false|
|user_id|integer|null: false, foreign_key: true|
|comment_id|integer|null: false, foreign_key: true|


### Association
- has_many : users
- has_many : comments



## imageテーブル
|Column|Type|Options|
|------|----|-------|
|id|integer|null: false|
|item_id|integer|null: false, foreign_key: true|
|url|string|   |


### Association
- belongs_to :item



## brandテーブル
|Column|Type|Options|
|------|----|-------|
|id|integer|null: false|
|name|string|null: false|


### Association
- belongs_to :item



## categoryテーブル
|Column|Type|Options|
|------|----|-------|
|id|integer|null: false|
|name|string|null: false|
|ancenstry|integer|null: false|


### Association
- belongs_to :item



## shippingテーブル
|Column|Type|Options|
|------|----|-------|
|id|integer|null: false|
|item_id|integer|null: false, foreign_key: true|
|method|string|null: false|


### Association
- belongs_to :item
