require 'rails_helper'

feature "Users" do
  before do
    @user = User.create!(
    first_name: "foo",
    last_name: "bar",
    email: "foo@bar.com",
    password: "test",
    admin: true
    )
    visit root_path
    click_on "Sign In"
    fill_in "Email", with: "foo@bar.com"
    fill_in "Password", with: "test"
    within(".well") do
      click_on("Sign In")
    end
  end

  scenario "creates a user" do
    visit users_path
    expect(page).to have_no_content("foo2")
    expect(page).to have_no_content("bar2")
    expect(page).to have_no_content("foo2@bar2.com")
    click_on "Create User"
    fill_in "First name", with: "foo2"
    fill_in "Last name", with: "bar2"
    fill_in "Email", with: "foo2@bar2.com"
    fill_in "Password", with: "test"
    fill_in "Password confirmation", with: "test"
    click_on "Create User"
    expect(page).to have_content("foo2")
    expect(page).to have_content("bar2")
    expect(page).to have_content("foo2@bar2.com")
  end

  scenario "creates a user w/o first name" do
    visit users_path
    expect(page).to have_no_content("foo2")
    expect(page).to have_no_content("bar2")
    expect(page).to have_no_content("foo2@bar2.com")
    click_on "Create User"
    fill_in "First name", with: ""
    fill_in "Last name", with: "bar2"
    fill_in "Email", with: "foo2@bar2.com"
    fill_in "Password", with: "test"
    fill_in "Password confirmation", with: "test"
    click_on "Create User"
    expect(page).to have_content("First name can't be blank")
  end

  scenario "creates a user w/o last name" do
    visit users_path
    expect(page).to have_no_content("foo2")
    expect(page).to have_no_content("bar2")
    expect(page).to have_no_content("foo2@bar2.com")
    click_on "Create User"
    fill_in "First name", with: "foo2"
    fill_in "Last name", with: ""
    fill_in "Email", with: "foo2@bar2.com"
    fill_in "Password", with: "test"
    fill_in "Password confirmation", with: "test"
    click_on "Create User"
    expect(page).to have_content("Last name can't be blank")
  end

  scenario "creates a user w/ non-uniqe email" do
    visit users_path
    click_on "Create User"
    fill_in "First name", with: "foo"
    fill_in "Last name", with: "foo"
    fill_in "Email", with: "foo@bar.com"
    fill_in "Password", with: "test"
    fill_in "Password confirmation", with: "test"
    click_on "Create User"
    expect(page).to have_content("Email has already been taken")
  end

  scenario "edits a user" do
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
    visit users_path
    expect(page).to have_content("foo")
    expect(page).to have_content("bar")
    expect(page).to have_content("foo@bar.com")
    within(".table") do
      click_on("foo bar")
    end
    expect(page).to have_content("foo")
    expect(page).to have_content("bar")
    expect(page).to have_content("foo@bar.com")
  end

  scenario "destroys a user" do
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
