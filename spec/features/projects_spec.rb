require 'rails_helper'

feature "Projects" do
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
    visit projects_path
    expect(page).to have_no_content("Foo")
    click_on "Create Project"
    fill_in "Name", with: "Foo"
    click_on "Create Project"
    expect(page).to have_content("Foo")
    click_on "Edit"
    fill_in "Name", with: "Bar"
    click_on "Update Project"
    expect(page).to have_content("Bar")
    expect(page).to have_no_content("Foo")
  end

  scenario "User destroys a project" do
    visit projects_path
    expect(page).to have_no_content("Foo")
    click_on "Create Project"
    fill_in "Name", with: "Foo"
    click_on "Create Project"
    expect(page).to have_content("Foo")
    click_on "Destroy"
    expect(page).to have_no_content("Foo")
  end

end
