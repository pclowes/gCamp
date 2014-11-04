require 'rails_helper'

feature "Projects" do
  scenario "User creates a project"
    visit projects_path
    expect(page).to have_no_content("Project")
    click_on "Create Project"
    fill_in "Name", with: "Project"
    click_on "Create Project"
    expect(page).to have_content("Project")

end
