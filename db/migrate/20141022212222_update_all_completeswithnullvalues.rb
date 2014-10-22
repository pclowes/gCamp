class UpdateAllCompleteswithnullvalues < ActiveRecord::Migration
  def change
      Task.update_all complete: false
  end
end
