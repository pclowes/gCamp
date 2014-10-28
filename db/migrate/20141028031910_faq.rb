class Faq < ActiveRecord::Migration
  def change
    create_table "faqs", force: true do |t|
      t.string   "question"
      t.string   "answer"
    end
  end
end
