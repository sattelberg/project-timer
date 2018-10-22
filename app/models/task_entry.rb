class TaskEntry < ApplicationRecord
  belongs_to :task
  validates :duration, presence: true, format: { with: /\A[0,1]*[0-9][0-9]:[0-2][0-3]:[0-5][0-9]\Z/i}
  validates :note, presence: true
  validates :start_time, presence: true
end
