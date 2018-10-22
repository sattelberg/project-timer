class ChangeDurationTypeInTaskEntries < ActiveRecord::Migration[5.1]
  def change
    change_column :task_entries, :duration, :string
  end
end
