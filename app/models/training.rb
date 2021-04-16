class Training < ApplicationRecord
  # Active Storageで画像をアップロード
  has_one_attached :image, dependent: false

  # アソシエーション
  belongs_to :owner, class_name: 'User'
  has_many :tickets, dependent: :destroy
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :prefecture

  # バリデーション
  with_options presence: true do
    validates :name, length: { maximum: 50 }
    validates :prefecture_id, numericality: { other_than: 1, message: 'を選択してください' }
    validates :place, length: { maximum: 100 }
    validates :start_at
    validates :end_at
    validates :content, length: { maximum: 200 }
  end
  validate :start_at_should_be_before_end_at
  # Active Storageのバリデーション
  validates :image,
            content_type: [:png, :jpg, :jpeg],
            size: { less_than_or_equal_to: 10.megabytes },
            dimension: { width: { max: 2000 }, height: { max: 2000 } }

  # 属性を宣言
  attr_accessor :remove_image

  before_save :remove_image_if_user_assept

  # メソッド
  def created_by?(user)
    return false unless user

    owner_id == user.id
  end

  # remove_imageがtrueであれば値をnilにする
  def remove_image_if_user_assept
    self.image = nil if ActiveRecord::Type::Boolean.new.cast(remove_image)
  end

  private

  def start_at_should_be_before_end_at
    return unless start_at && end_at

    errors.add(:start_at, 'は終了時間よりも前に設定してください') if start_at >= end_at
  end
end
