require 'rails_helper'

feature "Tasks" do
  scenario "User creates a task" do
    visit tasks_path
    expect(page).to have_no_content("foobar")
    expect(page).to have_no_content("2014-11-11")
    expect(page).to have_no_content("false")
    click_on "Create Task"
    fill_in "Description", with: "foobar"
    fill_in "Due date", with: "2014-11-11"
    click_on "Create Task"
    expect(page).to have_content("foobar")
    expect(page).to have_content("11/11/2014")
    expect(page).to have_content("false")
  end

  scenario "User creates a task w/o descritption" do
    visit tasks_path
    expect(page).to have_no_content("foobar")
    expect(page).to have_no_content("2014-11-11")
    expect(page).to have_no_content("false")
    click_on "Create Task"
    fill_in "Description", with: ""
    fill_in "Due date", with: "2014-11-11"
    click_on "Create Task"
    expect(page).to have_content("Description can't be blank")
  end

  scenario "User edits a task" do
    Task.create!(
      description: "foobar",
      due_date: "2014-11-11",
      complete: false
    )
    visit tasks_path
    expect(page).to have_content("foobar")
    expect(page).to have_content("11/11/2014")
    expect(page).to have_content("false")
    click_on "Edit"
    fill_in "Description", with: "oofrab"
    fill_in "Due date", with: "2012-01-01"
    page.check('Complete')
    click_on "Update Task"
    expect(page).to have_no_content("foobar")
    expect(page).to have_no_content("11/11/2014")
    expect(page).to have_no_content("false")
    expect(page).to have_content("oofrab")
    expect(page).to have_content("01/01/2012")
    expect(page).to have_content("true")
  end

  scenario "User shows a task" do
    Task.create!(
      description: "foobar",
      due_date: "2014-11-11",
      complete: false
    )
    visit tasks_path
    expect(page).to have_content("foobar")
    expect(page).to have_content("11/11/2014")
    expect(page).to have_content("false")
    click_on "Show"
    expect(page).to have_content("foobar")
    expect(page).to have_content("11/11/2014")
    expect(page).to have_content("false")
    click_on "Back"
    expect(page).to have_content("foobar")
    expect(page).to have_content("11/11/2014")
    expect(page).to have_content("false")
  end

  scenario "User deletes a task" do
    Task.create!(
      description: "foobar",
      due_date: "2014-11-11",
      complete: false
    )
    visit tasks_path
    expect(page).to have_content("foobar")
    expect(page).to have_content("11/11/2014")
    expect(page).to have_content("false")
    click_on "Destroy"
    expect(page).to have_no_content("foobar")
    expect(page).to have_no_content("11/11/2014")
    expect(page).to have_no_content("false")
  end
end
