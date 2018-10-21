class Customer < ApplicationRecord
  has_many :projects
  validates :company, presence: true
end
