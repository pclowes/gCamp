class Comments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.text :comment
      t.belongs_to :tasks
      t.belongs_to :users
      t.timestamps
    end
  end
end
