## アプリ名
Match Trainees

## 概要
トレーニングをしたい人同士をマッチングする、ウェブアプリケーションです。

## 本番環境
### デプロイ先
http://3.113.118.238/
### テストアカウント
|アカウント名|email|password|
|-|-|-|
|test-user1|example1@example.com|testtest1|
|test-user2|example@example.com|testtest2|

## 制作意図
トレーニングパートナーを募集することができれば、モチベーションやトレーニングの質を向上させられるのではないかと考え、制作しました。

## DEMO
## トップページ

## 工夫点
- フォームオブジェクトの導入  
マニュフェスト投稿時に、manifestテーブルとtagテーブルの情報が更新されるように、formオブジェクトを導入しています。ユースケースを想定しながらupdate、destroyアクションを定義することで、期待通りの機能を実装することができました。
## 使用技術

### バックエンド
Ruby, Ruby on Rails
### フロントエンド
ERB, Sass, JavaScript, Ajax
### データベース
Mysql, Sequel pro
### Webサーバ（本番環境）
Nginx
### アプリケーションサーバ（本番環境）
unicorn
### ソース管理
Github, GithubDesktop
### テスト
Rspec
### エディタ
VScode

## 課題・今後実装したい機能
- Vue.jsを用いたフロントエンドの実装
- ユーザーの体力レベルを登録し、公開する機能
- ユーザー同士のチャットルーム機能
- AWS Route53で独自ドメインを取得
- AWS Certificate ManagerでSSL証明書を発行し、アプリをSSL化

## DB設計
### users table
|Column|Types|Options|
|-|-|-|
|email|string|null:false, unique: true|
|nickname|string|null:false|

#### Association
- has_many :assemblymen
- has_one :comments, dependent: :destroy
- has_one :manifests, dependent: :destroy

### sns_credentials
|Column|Types|Options|
|-|-|-|
|provider|string|-|
|uid|string|-|
|user|references|foreign_key: true|

#### Association
- belongs_to :user, optional: true

### prefecture table
|Column|Types|Options|
|-|-|-|
|name|string|null:false|

#### Association
- has_many :council

### council table
|Column|Types|Options|
|-|-|-|
|name|string|null:false|
|prefecture|references|null:false, foreign_key: true|
|election_day|date||

#### Association
- belongs_to :prefecture
- has_many :assemblymen

### assemblymen table
|Column|Types|Options|
|-|-|-|
|name|string|null:false|
|sex|string||
|birth_of_date|date||
|position|string||
|faction|string||
|number_of_wins|integer||
|img_url|text||
|job|string||
|twitter_url|text||
|council|references|null:false, foreign_key: true|
|user|references|foreign_key: true|

#### Association
- belongs_to :council
- belongs_to :user, optional: true
- has_one :comments, dependent: :destroy

### manifest table
|Column|Types|Options|
|-|-|-|
|title|string|null:false|
|description|text|null:false|
|user|references|null:false, foreign_key:true|

#### Association
- belongs_to :user
- has_many :manifest_tag_relations
- has_many :tags, through: :manifest_tag_relations

### tags table
|Column|Types|Options|
|-|-|
|name|string|null:false, uniqueness: true|

#### Association
- has_many :manifest_tag_relations
- has_many :manifests, through: :manifest_tag_relations

### manifest_tag_relations table
|Column|Types|Options|
|-|-|
|manifest|references|foreign_key: true|
|tag|references|foreign_key: true|

#### Association
- belongs_to :manifest
- belongs_to :tag 

### comments table
|Column|Types|Options|
|-|-|-|
|comment|text|null:false|
|user|references|foreign_key: true|
|assemblyman|references|foreign_key: true|

#### Association
- belongs_to :user
- belongs_to :assemblyman

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
|prefecture_id|integer|null: false|
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

