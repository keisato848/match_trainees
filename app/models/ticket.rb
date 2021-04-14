class Ticket < ApplicationRecord
  belongs_to :user, optional: true
  belongs_to :training

  validates :comment, length: { maximum: 30 }, allow_blank: true
end
