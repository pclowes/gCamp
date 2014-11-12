require 'rails_helper'
describe User do
  it 'validates the uniqueness of a users email' do
    User.create!(
      first_name: "foo",
      last_name: "bar",
      email: "foo@bar.com",
      password: "test",
      password_confirmation: "test"
    )
    user = User.new(
      first_name: "foo",
      last_name: "bar",
      email: "foo@bar.com",
      password: "test",
      password_confirmation: "test"
    )
    user.valid?
    expect(user.errors[:email].present?).to eq(true)

    user.email = 'oof@bar.com'
    user.valid?
    expect(user.errors[:email].present?).to eq(false)
  end
end
