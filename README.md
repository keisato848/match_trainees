## テーブル設計

## users table
|Columns|Types|Options|
|-|-|-|
|name|string|null: false|
|provider|string||
|uid|string||
|image_url|string||

### Association
- has_many :trainings
- has_many :tickets

## trainings table
|Columns|Types|Options|
|-|-|-|
|context|text|null: false|
|name|string|null: false|
|img_url|string||
|region_id|integer|null: false|
|place|string|null: false|
|start_at|datetime|null: false|
|end_at|datetime|null: false|

### Association
- belongs_to :user
- has_many :tickets

## tickets table
|Columns|Types|Options|
|-|-|-|
|comment|string||

### Association
- belongs_to :user
- belongs_to :ticket

