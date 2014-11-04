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

feature "Signups" do
  scenario "User signs up no email" do
    visit root_path
    click_on "Sign Up"
    fill_in "First name", with: "Foo"
    fill_in "Last name", with: "Bar"
    fill_in "Email", with: ""
    fill_in "Password", with: "test"
    fill_in "Password confirmation", with: "test"
    within(".well") do
      click_on("Sign Up")
    end
    expect(page).to have_content("Email can't be blank")
  end
end

feature "Signups" do
  scenario "User signs up no passwords" do
    visit root_path
    click_on "Sign Up"
    fill_in "First name", with: "Foo"
    fill_in "Last name", with: "Bar"
    fill_in "Email", with: "foo@bar.com"
    fill_in "Password", with: ""
    fill_in "Password confirmation", with: ""
    within(".well") do
      click_on("Sign Up")
    end
    expect(page).to have_content("Password can't be blank")
  end
end

feature "Signups" do
  scenario "User signs up mismatched passwords" do
    visit root_path
    click_on "Sign Up"
    fill_in "First name", with: "Foo"
    fill_in "Last name", with: "Bar"
    fill_in "Email", with: "foo@bar.com"
    fill_in "Password", with: "test"
    fill_in "Password confirmation", with: "fest"
    within(".well") do
      click_on("Sign Up")
    end
    expect(page).to have_content("Password confirmation doesn't match Password")
  end
end
