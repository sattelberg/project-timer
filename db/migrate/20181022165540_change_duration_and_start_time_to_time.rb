class ChangeDurationAndStartTimeToTime < ActiveRecord::Migration[5.1]
  def change
    change_column :task_entries, :duration, :time
    change_column :task_entries, :start_time, :time
  end
end
