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
|test-user2|example2@example.com|testtest2|

## 制作意図
トレーニングへのモチベーションや練習効率を向上させるため、練習相手を募集するアプリケーションを制作しました。健康寿命延伸の意味でもトレーナーがいるジムに行きたくても金銭的な余裕がない方や、出張先や旅行先で練習相手を募集したい方の利用を想定しております。また、ユーザー同士が交流することで、トレーニングを継続させ、健康寿命を延伸させたいと考えております。

## DEMO
## トップページ
[![Image from Gyazo](https://i.gyazo.com/9a9f4d683c0e9e4a905f02390cfdff7b.png)](https://gyazo.com/9a9f4d683c0e9e4a905f02390cfdff7b)
## トレーニング作成機能
[![Image from Gyazo](https://i.gyazo.com/cfaeef3ae09c6f7ecf1e50f3e026c477.gif)](https://gyazo.com/cfaeef3ae09c6f7ecf1e50f3e026c477)
## トレーニング編集機能
[![Image from Gyazo](https://i.gyazo.com/e66d8522dd46191fe68c4184dad32de8.gif)](https://gyazo.com/e66d8522dd46191fe68c4184dad32de8)
## トレーニング参加機能
[![Image from Gyazo](https://i.gyazo.com/e7cae5ab11f990f865a635bba5239098.gif)](https://gyazo.com/e7cae5ab11f990f865a635bba5239098)
## エラーハンドリング
エラーは開発環境で再現しております。  
404エラー
[![Image from Gyazo](https://i.gyazo.com/257fedc1bb62f5c3cda820ca9966da4e.gif)](https://gyazo.com/257fedc1bb62f5c3cda820ca9966da4e)
500エラー
[![Image from Gyazo](https://i.gyazo.com/f2bcfa583c34b14e8f9f8d10d188fdf4.gif)](https://gyazo.com/f2bcfa583c34b14e8f9f8d10d188fdf4)

## 工夫点
- Vue.jsの導入
javascriptのフレームワークである、Vue.jsを活用し、非同期通信を実現しています。Vue.jsを活用することで、ユーザーフレンドリーなUIを実現しています。
- エラーハンドリング
アプリケーションの外で発生した例外を捕捉していない場合、ユーザに意図していないエラーページが見えている可能性があるため、rescue_fromで拾えない例外をexceptions_appで処理し、エラーページを統一しています。
## 使用技術

### バックエンド
Ruby, Ruby on Rails
### フロントエンド
ERB, Scss, Sass, JavaScript, Ajax
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
- トレーニング日記機能
- トレーニングスコアのランキング機能
- 個人チャット機能
- AWS Route53で独自ドメインを取得
- AWS Certificate ManagerでSSL証明書を発行し、アプリケーションをSSL化

## DB設計
### users table
|Column|Types|Options|
|-|-|-|
|email|string|null:false, unique: true|
|name|string|null:false|
|provider|string||
|uid|string||
|image_url|string|

#### Association
- has_many :tickets, dependent: :nullify
- has_many :participating_trainings, through: :tickets, source: :training
- has_many :training_scores, dependent: :destroy

### training_scores table
|Column|Types|Options|
|-|-|-|
|bench_press_weight|integer||
|squat_weight|integer||
|deadlift|integer||

#### Association
- belongs_to :user

### prefecture table
|Column|Types|Options|
|-|-|-|
|name|string|null:false|

#### Association
- has_many :council

### trainings table
|Column|Types|Options|
|-|-|-|
|owner|bigint||
|name|string|null: false|
|prefecture_id|bigint|null: false|
|place|string|null: false|
|start_at|datetime|null: false|
|end_at|datetime|null: false|
|content|text|null: false|

#### Association
- belongs_to :owner, class_name: 'User'
- has_many :tickets, dependent: :destroy

### tickets table
|Column|Types|Options|
|-|-|-|
|user|references||
|training|references|null: false, foreign_key: true, index: false|
|comment|string||

#### Association
- belongs_to :user, optional: true
- belongs_to :training
