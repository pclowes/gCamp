class MembershipsCreate < ActiveRecord::Migration
  def change
    create_table :memberships do |t|
      t.belongs_to :project
      t.belongs_to :user
      t.boolean :title
    end
  end
end
