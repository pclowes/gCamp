class ChangeInttoString < ActiveRecord::Migration
  def up
    change_table :memberships do |t|
      t.change :title, :string
    end
  end

  def down
    change_table :memberships do |t|
      t.change :title, :integer
    end
  end
end
