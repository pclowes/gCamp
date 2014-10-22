class UpdateCompleteColumnDefinitiontoHaveNullFalse < ActiveRecord::Migration
  def change
    change_column_null :tasks, :complete, false
  end
end
