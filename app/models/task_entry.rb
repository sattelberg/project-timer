class TaskEntry < ApplicationRecord
  belongs_to :task
  validates :note, presence: true, on: :update
end
