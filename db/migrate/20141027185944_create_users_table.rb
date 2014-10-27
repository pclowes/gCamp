class CreateUsersTable < ActiveRecord::Migration
  def change
    create_table "users", force: true do |t|
      t.string   "first_name"
      t.string   "last_name"
      t.string   "last_name"
    end
  end
end
