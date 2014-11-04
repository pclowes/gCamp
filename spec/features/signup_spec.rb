require 'rails_helper'

feature "Signups" do
  scenario "User signs up"
    visit root_path
    click_on "Sign Up"
    fill_in "First Name", with: "Foo"
    fill_in "Last Name", with: "Bar"
    fill_in "Email", with: "foo@bar.com"
    fill_in "Password", with: "test"
    fill_in "Password confirmation", with: "test"
    click_on "Sign Up"

end
