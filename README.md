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
|area|string|null: false|
|address_1|string|null: false|
|address_2|string|null: false|
|address_3|string|null: false|
|address_4|string|   |
|credit_card_id|integer|foreign_key: true|
|avatar|string|   |

### Association
- has_many :reviews
- has_many :tradings
- belongs_to :credit_card
- has_many :comments, through: :users_comments

#### メモ
- uniqueキー :tel_number, credit_card_id




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
|card_name|string|null: false|
|number|integer|null: false|
|pin|integer|null: false|
|company|srring|nill: false|

### Association
- has_one :user

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
- has_many :items



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
- belongs_to :trading
- belongs_to :brand
- belongs_to :category
- has_many :comments
- has_many :shippings
- has_many :images



## commentテーブル
|Column|Type|Options|
|------|----|-------|
|id|integer|null: false|
|text|string|   |
|item_id|integer|null: false, foreign_key: true|
|users_comments_id|integer|null: false, foreign_key: true|


### Association
- belongs_to :item
- belongs_to :users_comments
- has_many :users, through: :users_comments



## users_commentsテーブル
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
|url_1|string|   |
|url_2|string|   |
|url_3|string|   |
|url_4|string|   |
|url_5|string|   |
|url_6|string|   |
|url_7|string|   |
|url_8|string|   |
|url_9|string|   |
|url_10|string|   |


### Association
- belongs_to :item



## brandテーブル
|Column|Type|Options|
|------|----|-------|
|id|integer|null: false|
|item_id|integer|null: false, foreign_key: true|
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
