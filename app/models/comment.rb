class Comment < ApplicationRecord
  belongs_to :item
  belongs_to :user
  validates :text, { presence: true, length: { maximum: 140 } }
end
