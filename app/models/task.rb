class Task < ActiveRecord::Base
  validates :description, presence: true
  validate :due_date_cannot_be_in_the_past

  def due_date_cannot_be_in_the_past
    if due_date? && due_date < Date.today
      errors.add(:due_date, "can't be in the past")
    end
  end

  def upcoming?
    if self.due_date
      self.due_date <= (Date.today + 7)
    end
  end
end
