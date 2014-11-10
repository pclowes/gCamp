require 'rails_helper'

feature "Users" do
  scenario "creates a user" do
    visit users_path
    expect(page).to have_no_content("foo")
    expect(page).to have_no_content("bar")
    expect(page).to have_no_content("foo@bar.com")
    click_on "Create User"
    fill_in "First name", with: "foo"
    fill_in "Last name", with: "bar"
    fill_in "Email", with: "foo@bar.com"
    fill_in "Password", with: "test"
    fill_in "Password confirmation", with: "test"
    click_on "Create User"
    expect(page).to have_content("foo")
    expect(page).to have_content("bar")
    expect(page).to have_content("foo@bar.com")
  end
  

  scenario "edits a user" do
    User.create!(
      first_name: "foo",
      last_name: "bar",
      email: "foo@bar.com",
      password: "test",
      password_confirmation: "test"
    )
    visit users_path
    expect(page).to have_content("foo")
    expect(page).to have_content("bar")
    expect(page).to have_content("foo@bar.com")
    click_on "Edit"
    fill_in "First name", with: "oof"
    fill_in "Last name", with: "rab"
    fill_in "Email", with: "rab@oof.com"
    click_on "Update User"
    expect(page).to have_no_content("foo")
    expect(page).to have_no_content("bar")
    expect(page).to have_no_content("foo@bar.com")
    expect(page).to have_content("oof")
    expect(page).to have_content("rab")
    expect(page).to have_content("rab@oof.com")
  end

  scenario "shows a user" do
    User.create!(
      first_name: "foo",
      last_name: "bar",
      email: "foo@bar.com",
      password: "test",
      password_confirmation: "test"
    )
    visit users_path
    expect(page).to have_content("foo")
    expect(page).to have_content("bar")
    expect(page).to have_content("foo@bar.com")
    click_on "foo bar"
    expect(page).to have_content("foo")
    expect(page).to have_content("bar")
    expect(page).to have_content("foo@bar.com")
  end

  scenario "destroys a user" do
    User.create!(
      first_name: "foo",
      last_name: "bar",
      email: "foo@bar.com",
      password: "test",
      password_confirmation: "test"
    )
    visit users_path
    expect(page).to have_content("foo")
    expect(page).to have_content("bar")
    expect(page).to have_content("foo@bar.com")
    click_on "Edit"
    click_on "Destroy"
    expect(page).to have_no_content("foo")
    expect(page).to have_no_content("bar")
    expect(page).to have_no_content("foo@bar.com")
  end
end
