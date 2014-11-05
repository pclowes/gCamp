require 'rails_helper'

feature "Signout" do
  scenario "User signs out" do
    User.create!(
      first_name: "Foo2",
      last_name: "11/11/13",
      email: "foo2@bar.com",
      password: "test"
    )
    visit root_path
    click_on "Sign In"
    fill_in "Email", with: "foo2@bar.com"
    fill_in "Password", with: "test"
    within(".well") do
      click_on("Sign In")
    end
    visit root_path
    expect(page).to have_no_content("Sign Up")
    expect(page).to have_no_content("Sign In")
    expect(page).to have_content("Sign Out")

    click_on "Sign Out"
    expect(page).to have_content("Sign Up")
    expect(page).to have_content("Sign In")
    expect(page).to have_no_content("Sign Out")
  end
end
