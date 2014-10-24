class Task < ActiveRecord::Base
  def upcoming?
    if self.due_date
      self.due_date <= (Date.today + 7)
    end
  end
end
