class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :omniauthable, omniauth_providers: [:github]
  before_destroy :check_all_events_finished

  has_many :created_trainings, class_name: 'Training', foreign_key: 'owner_id', dependent: :nullify
  has_many :tickets, dependent: :nullify
  has_many :participating_trainings, through: :tickets, source: :training
  has_many :user_additional_profiles, dependent: :destroy

  VALID_PASSWORD_REGEX = /\A(?=.*?[a-z])(?=.*?\d)\w{6,12}\z/.freeze
  validates :password, format: { with: VALID_PASSWORD_REGEX }
  validates :name, presence: true, uniqueness: true, length: { maximum: 40 }
  validates :image_url, allow_blank: true, format: { with: URI::DEFAULT_PARSER.make_regexp(%w[http https]) }

  def self.from_omniauth(auth)
    provider = auth.provider
    uid = auth.uid
    nickname = auth.info.nickname
    image_url = auth.info.image

    # providerとuidを持つレコードが存在しているか判別し、なければ生成
    User.find_or_create_by(provider: provider, uid: uid) do |user|
      user.name = nickname
      user.image_url = image_url
    end
  end

  def check_all_events_finished
    now = Time.zone.now
    errors[:base] << '公開中の未終了イベントが存在します' if created_trainings.where(':now < end_at', now: now).exists?
    errors[:base] << '未終了の参加イベントが存在します' if participating_trainings.where(':now < end_at', now: now).exists?
    # エラー時は処理を中断
    throw(:abort) unless errors.empty?
  end
end
