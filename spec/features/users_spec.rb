require 'rails_helper'

feature "Users" do
  scenario "creates a user" do
    visit users_path
    expect(page).to have_no_content("Blah")
    click_on "Create User"
    fill_in "First name", with: "Blah"
    fill_in "Last name", with: "Bar"
    fill_in "Email", with: "blah@bar.com"
    fill_in "Password", with: "test"
    fill_in "Password confirmation", with: "test"
    click_on "Create User"
    expect(page).to have_content("Foo")
  end

  scenario "edits a user" do
    User.create!(
      first_name: "baz",
      last_name: "bar",
      email: "baz@bar.com",
      password: "test",
      password_confirmation: "test"
    )
    visit users_path
    expect(page).to have_content("baz")
    click_on "Edit"
    fill_in "First name", with: "Blah"
    fill_in "Last name", with: "Bar"
    fill_in "Email", with: "blah@bar.com"
    click_on "Update User"
    expect(page).to have_content("Blah")
    expect(page).to have_no_content("baz")
  end

  scenario "shows a user" do
    User.create!(
      first_name: "baz",
      last_name: "bar",
      email: "baz@bar.com",
      password: "test",
      password_confirmation: "test"
    )
    visit users_path
    expect(page).to have_content("baz")
    click_on "baz"
    expect(page).to have_content("baz")
  end

  scenario "destroys a user" do
    User.create!(
      first_name: "baz",
      last_name: "bar",
      email: "baz@bar.com",
      password: "test",
      password_confirmation: "test"
    )
    visit users_path
    expect(page).to have_content("baz")
    click_on "Edit"
    click_on "Destroy"
    expect(page).to have_no_content("baz")
  end
end
