require 'rails_helper'

feature "Signin" do
  scenario "User signs in" do
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
  end
end

feature "Signin" do
  scenario "User signs in bad password" do
    User.create!(
      first_name: "Foo2",
      last_name: "11/11/13",
      email: "foo2@bar.com",
      password: "test"
    )
    visit root_path
    click_on "Sign In"
    fill_in "Email", with: "foo2@bar.com"
    fill_in "Password", with: "fest"
    within(".well") do
      click_on("Sign In")
    end
    expect(page).to have_content("Username / password combination is invalid")
  end
end
