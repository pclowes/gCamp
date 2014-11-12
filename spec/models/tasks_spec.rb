require 'rails_helper'
describe Task do

  it "saves a task w/o due date" do
    task = Task.new(description: 'foo')
    task.save
    expect(task.valid?).to eq(true)
  end

  it "does not save a task w/ due date in the past" do
    task = Task.create(description: 'foo', due_date: Date.yesterday.strftime("%m/%d/%Y").to_s)
    expect(task.valid?).to eq(false)
  end


  include ActiveSupport::Testing::TimeHelpers
  it "updates a task with a due date in the past" do
    task = Task.new
    travel_to 1.year.ago do
      task.description= 'foobar'
      task.due_date= Date.today
      expect(task.valid?).to eq(true)
      task.save
    end
    task.description = 'oofrab'
    expect(task.valid?).to eq(true)
  end
end
