require 'rails_helper'

feature "Users" do
  scenario "User creates a user"
    visit users_path
    expect(page).to have_no_content("Foo")
    click_on "Create User"
    fill_in "First Name", with: "Foo"
    fill_in "Last Name", with: "Bar"
    fill_in "Email", with: "foo@bar.com"
    fill_in "Password", with: "test"
    fill_in "Password confirmation", with: "test"
    click_on "Create User"
    expect(page).to have_content("Foo")

end
