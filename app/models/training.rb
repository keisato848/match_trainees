class Training < ApplicationRecord
  
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :prefecture
  
  with_options presence: true do
    validates :name, length: { maximum: 50 }
    validates :place, length: { maximum: 100 }
    validates :content, length: { maximum: 200 }
    validates :start_at
    validates :end_at
  end
  validate :start_at_should_be_before_end_at

  private
  def start_at_should_be_before_end_at
    return unless start_at && end_at

    if start_at >= end_at
      errors.add(:start_at, "は終了時間よりも前に設定してください")
    end
  end
end
