require 'rails_helper'

feature "Signin" do
  scenario "sign in" do
    User.create!(
      first_name: "foo",
      last_name: "bar",
      email: "foo@bar.com",
      password: "test"
    )
    visit root_path
    expect(page).to have_content("Sign Up")
    expect(page).to have_content("Sign In")
    click_on "Sign In"
    fill_in "Email", with: "foo@bar.com"
    fill_in "Password", with: "test"
    within(".well") do
      click_on("Sign In")
    end
    expect(page).to have_no_content("Sign Up")
    expect(page).to have_no_content("Sign In")
    expect(page).to have_content("foo bar")
    expect(page).to have_content("Sign Out")
  end

  scenario "incorrect password" do
    User.create!(
      first_name: "foo",
      last_name: "bar",
      email: "foo@bar.com",
      password: "test"
    )
    visit root_path
    expect(page).to have_content("Sign Up")
    expect(page).to have_content("Sign In")
    click_on "Sign In"
    fill_in "Email", with: "foo@bar.com"
    fill_in "Password", with: "incorrect"
    within(".well") do
      click_on("Sign In")
    end
    expect(page).to have_content("Username / password combination is invalid")
  end
end
