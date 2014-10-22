class AddDueDateCompleteToTasks < ActiveRecord::Migration
  def change
    rename_column :tasks, :Due_date, :due_date
  end
end
