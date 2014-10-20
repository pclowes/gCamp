class AddDueDateToTasks < ActiveRecord::Migration
  def change
    add_column :tasks, :Due_date, :date
  end
end
