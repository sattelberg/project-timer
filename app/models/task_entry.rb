class TaskEntry < ApplicationRecord
  belongs_to :task
  validates :duration, presence: true
  validates :note, presence: true
  validates :start_time, presence: true
end
