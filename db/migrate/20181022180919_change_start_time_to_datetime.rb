class ChangeStartTimeToDatetime < ActiveRecord::Migration[5.1]
  def change
    change_column :task_entries, :start_time, :datetime
  end
end
