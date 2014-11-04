require 'rails_helper'

feature "Signin" do
  scenario "User signs in"
    User.create!(
      first_name: "Foo",
      last_name: "11/11/13",
      email: "foo@bar.com",
      password: "test"
    )
    visit root_path
    click_on "Sign In"
    fill_in "Email", with: "foo@bar.com"
    fill_in "Password", with: "test"
    click_on "Sign In"

end
