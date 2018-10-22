class Customer < ApplicationRecord
  has_many :projects
  validates :company, presence: true
  validates :zip, format: { with: /\A\d{5}(\d{4})??\z/}
end
