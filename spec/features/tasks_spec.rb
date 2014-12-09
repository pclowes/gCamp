require 'rails_helper'
require 'date'

feature "Tasks" do
  before do
    @user = User.create!(
    first_name: "foo",
    last_name: "bar",
    email: "foo@bar.com",
    password: "test"
    )
    @project = Project.create!(
    name: "Test Project",
    )
    @membership = Membership.create!(
    user: @user,
    project: @project,
    title: 'Owner',
    )
    visit root_path
    click_on "Sign In"
    fill_in "Email", with: "foo@bar.com"
    fill_in "Password", with: "test"
    within(".well") do
      click_on("Sign In")
    end
  end

  scenario "User creates a task" do
    visit projects_path
    expect(page).to have_content("Test Project")
    within(".table") do
      click_on("Test Project")
    end
    expect(page).to have_content("0 Tasks")
    click_on "0 Tasks"
    expect(page).to have_content("Tasks for Test Project")
    expect(page).to have_no_content("foobar")
    expect(page).to have_no_content(Date.tomorrow.to_s)
    expect(page).to have_no_content("false")
    click_on "Create Task"
    fill_in "Description", with: "foobar"
    fill_in "Due date", with: Date.tomorrow.to_s
    click_on "Create Task"
    expect(page).to have_content("foobar")
    expect(page).to have_content(Date.tomorrow.strftime("%m/%d/%Y").to_s)
    expect(page).to have_content("false")
  end

  scenario "User creates a task w/o description" do
    Project.create!(
      name: "Test Project"
    )
    visit projects_path
    expect(page).to have_content("Test Project")
    within(".table") do
      click_on("Test Project")
    end
    expect(page).to have_content("0 Tasks")
    click_on "0 Tasks"
    expect(page).to have_content("Tasks for Test Project")
    expect(page).to have_no_content("foobar")
    expect(page).to have_no_content(Date.today.to_s)
    expect(page).to have_no_content("false")
    click_on "Create Task"
    fill_in "Description", with: ""
    fill_in "Due date", with: Date.today.to_s
    click_on "Create Task"
    expect(page).to have_content("Description can't be blank")
  end

  scenario "User creates a task w/ due date in the past" do
    visit projects_path
    expect(page).to have_content("Test Project")
    within(".table") do
      click_on("Test Project")
    end
    expect(page).to have_content("0 Tasks")
    click_on "0 Tasks"
    expect(page).to have_content("Tasks for Test Project")
    expect(page).to have_no_content("foobar")
    expect(page).to have_no_content("2011-11-11")
    expect(page).to have_no_content("false")
    click_on "Create Task"
    fill_in "Description", with: "foobar"
    fill_in "Due date", with: "2011-11-11"
    click_on "Create Task"
    expect(page).to have_content("Due date can't be in the past")
  end

  scenario "User edits a task" do
    @project.tasks.create!(
    description: "foobar",
    due_date: Date.tomorrow.to_s,
    complete: false
    )

    visit project_tasks_path(@project)
    within(".table") do
      expect(page).to have_content("foobar")
      expect(page).to have_content(Date.tomorrow.strftime("%m/%d/%Y").to_s)
      expect(page).to have_content("false")
    end

    click_on "Edit"
    fill_in "Description", with: "oofrab"
    fill_in "Due date", with: 2.days.from_now
    page.check('Complete')
    click_on "Update Task"
    within(".breadcrumb") do
      click_on "Tasks"
    end
    click_on "All"
    expect(Task.count).to eq(1)
    within(".table") do
      expect(page).to have_content("oofrab")
      expect(page).to have_content(2.days.from_now.strftime("%m/%d/%Y").to_s)
      expect(page).to have_content("true")
    end
  end

  scenario "User shows a task" do
    @project.tasks.create!(
    description: "foobar",
    due_date: Date.tomorrow.to_s,
    complete: false
    )
    visit project_tasks_path(@project)
    expect(page).to have_content("foobar")
    expect(page).to have_content(Date.tomorrow.strftime("%m/%d/%Y").to_s)
    expect(page).to have_content("false")
    click_on "foobar"
    expect(page).to have_content("foobar")
    expect(page).to have_content(Date.tomorrow.strftime("%m/%d/%Y").to_s)
    expect(page).to have_content("false")
  end

  scenario "User deletes a task" do
    @project.tasks.create!(
    description: "foobar",
    due_date: Date.tomorrow.to_s,
    complete: false
    )
    visit project_tasks_path(@project)
    expect(page).to have_content("foobar")
    expect(page).to have_content(Date.tomorrow.strftime("%m/%d/%Y").to_s)
    expect(page).to have_content("false")
    click_on "Delete"
    expect(page).to have_no_content("foobar")
    expect(page).to have_no_content(Date.tomorrow.strftime("%m/%d/%Y").to_s)
    expect(page).to have_no_content("false")
  end
end
