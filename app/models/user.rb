class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :omniauthable, omniauth_providers: [:github]

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
end
