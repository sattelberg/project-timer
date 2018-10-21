class CreateTaskEntries < ActiveRecord::Migration[5.1]
  def change
    create_table :task_entries do |t|
      t.references :task, foreign_key: true
      t.bigint :duration
      t.string :note
      t.datetime :start_time

      t.timestamps
    end
  end
end
