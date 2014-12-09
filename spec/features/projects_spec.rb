require 'rails_helper'

feature "Projects" do
  before do
    @user = User.create!(
    first_name: "foo",
    last_name: "bar",
    email: "foo@bar.com",
    password: "test"
    )
    visit root_path
    click_on "Sign In"
    fill_in "Email", with: "foo@bar.com"
    fill_in "Password", with: "test"
    within(".well") do
      click_on("Sign In")
    end
  end

  scenario "User creates a project" do
    visit projects_path
    expect(page).to have_no_content("Foo")
    click_on "Create Project"
    fill_in "Name", with: "Foo"
    click_on "Create Project"
    expect(page).to have_content("Foo")
  end

  scenario "User creates a project w/o name" do
    visit projects_path
    expect(page).to have_no_content("Foo")
    click_on "Create Project"
    fill_in "Name", with: ""
    click_on "Create Project"
    expect(page).to have_content("Name can't be blank")
  end


  scenario "User edits a project" do
    @project = Project.create!(
    name: "Test Project",
    )
    Membership.create!(
    user: @user,
    project: @project,
    title: 'Owner',
    )
    visit projects_path
    expect(page).to have_content("Test Project")
    within(".table") do
      click_on("Test Project")
    end
    click_on "Edit"
    fill_in "Name", with: "Bar"
    click_on "Update Project"
    expect(page).to have_content("Bar")
    expect(page).to have_no_content("Test Project")
  end

  scenario "User destroys a project" do
    @project = Project.create!(
    name: "Test Project",
    )
    Membership.create!(
    user: @user,
    project: @project,
    title: 'Owner',
    )
    visit projects_path
    expect(page).to have_content("Test Project")
    within(".table") do
      click_on("Test Project")
    end
    click_on "Delete"
    expect(page).to have_no_content("Test Project")
  end

end
