class Quotes < ActiveRecord::Migration
  def change
    create_table "quotes", force: true do |t|
      t.string   "quote"
      t.string   "author"
    end
  end
end
