require 'rails_helper'

feature "Signups" do
  scenario "User signs up" do
    visit root_path
    click_on "Sign Up"
    fill_in "First name", with: "Foo"
    fill_in "Last name", with: "Bar"
    fill_in "Email", with: "foo@bar.com"
    fill_in "Password", with: "test"
    fill_in "Password confirmation", with: "test"
    within(".well") do
      click_on("Sign Up")
    end
  end
end
