class Task < ActiveRecord::Base
  validates :description, presence: true
  def upcoming?
    if self.due_date
      self.due_date <= (Date.today + 7)
    end
  end
end
