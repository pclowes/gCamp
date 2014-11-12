require 'rails_helper'
describe Task do

  it "saves a task w/o due date" do
    task = Task.new(description: 'foo')
    task.save
    expect(task.valid?).to be(true)
  end

  it "does not save a task w/ due date in the past" do
    task = Task.create(description: 'foo', due_date: Date.yesterday.strftime("%m/%d/%Y").to_s)
    expect(task.valid?).to be(false)
  end

  it "updates a task with a due date in the past" do
    Task.create(
      description: "foobar",
      due_date: '2011-10-10',
      complete: false
    )
  end
end
