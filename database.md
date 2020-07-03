# users table
(作成しない)ユーザーの情報を管理する
## columns
|name|type|options|
|-|-|-|
|name|str|null: false, index: true, unique: true|
## associations
- has_many :members
- has_many :groups, through: :members
- has_many :messages
## validations
- validates :name, presence: true, uniqueness: true


# groups
チャットグループの情報を管理する
## columns
|name|type|options|
|-|-|-|
|name|str|null: false|
## associations
- has_many :members
- has_many :users, through: :members
- has_many :messages
## validations
- validates :name, presence: true


# members
（作成しない）どのgroupにどのuserが所属しているか管理する
## columns
|name|type|options|
|-|-|-|
|user|references|null: false, foreign_key: true|
|group|references|null: false, foreign_key: true|
## associations
- belongs_to :user
- belongs_to :group
## validations
- validates :user_id, uniqueness: { scope: :group_id }


# messages
投稿されたメッセージの情報を管理する
## columns
|name|type|options|
|-|-|-|
|content|text|null: false|
|user|references|null: false, foreign_key: true|
|group|references|null: false, foreign_key: true|
## associations
- belongs_to :user
- belongs_to :group
## validations
- validates :content, presence: true
