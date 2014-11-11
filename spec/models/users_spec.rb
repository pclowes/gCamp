require 'rails_helper'

describe User do
  it 'creates a user w/ non-unique email' do
    User.create!(
      first_name: "foo",
      last_name: "bar",
      email: "foo@bar.com",
      password: "test",
      password_confirmation: "test"
    )
    user = User.new
    expect(user.valid?).to be(false)
    user.first_name = 'foo'
    expect(user.valid?).to be(false)
    user.last_name = 'bar'
    expect(user.valid?).to be(false)
    user.email = 'foo@bar.com'
    expect(user.valid?).to be(false)
    user.password = 'test'
    user.password_confirmation = 'test'
    expect(user.valid?).to be(false)
  end
end
