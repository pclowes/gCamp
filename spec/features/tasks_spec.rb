require 'rails_helper'

feature "Tasks" do
  scenario "User creates a task" do
    visit tasks_path
    expect(page).to have_no_content("Test")
    click_on "Create Task"
    fill_in "Description", with: "Test"
    fill_in "Due date", with: "11/11/14"
    click_on "Create Task"
    expect(page).to have_content("Test")
  end

  scenario "User edits a task" do
    Task.create!(
      description: "Noteditedyettask",
      due_date: "11/11/13",
      complete: false
    )
    visit tasks_path
    expect(page).to have_content("Noteditedyettask")
    click_on "Edit"
    fill_in "Description", with: "Edittasktest"
    fill_in "Due date", with: "11/11/14"
    click_on "Update Task"
    expect(page).to have_content("Edittasktest")
    expect(page).to have_no_content("Noteditedyettask")
  end

  scenario "User shows a task" do
    Task.create!(
      description: "showtask",
      due_date: "11/11/13",
      complete: false
    )
    visit tasks_path
    expect(page).to have_content("showtask")
    click_on "Show"
    expect(page).to have_content("showtask")
    click_on "Back"
    expect(page).to have_content("showtask")
  end

  scenario "User deletes a task" do
    Task.create!(
      description: "Notdeletedyettask",
      due_date: "11/11/13",
      complete: false
    )
    visit tasks_path
    expect(page).to have_content("Notdeletedyettask")
    click_on "Destroy"
    expect(page).to have_no_content("Notdeletedyettask")
  end
end
