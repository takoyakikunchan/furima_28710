class Address < ApplicationRecord
  belongs_to :order
  belongs_to :user, optional: true
end
