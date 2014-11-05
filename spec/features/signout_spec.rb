require 'rails_helper'

feature "Signout" do
  scenario "User signs out" do
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
    visit root_path
    expect(page).to have_no_content("Sign Up")
    expect(page).to have_no_content("Sign In")
    expect(page).to have_content("Sign Out")
    expect(page).to have_content("foo@bar.com")
    click_on "Sign Out"
    expect(page).to have_content("Sign Up")
    expect(page).to have_content("Sign In")
    expect(page).to have_no_content("Sign Out")
    expect(page).to have_no_content("foo@bar.com")
  end
end
