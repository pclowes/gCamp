module ObjectCreationMethods

  def new_user(overrides = {})
    defaults = {
      first_name: Faker::Name.first_name,
      last_name: Faker::Name.last_name,
      email: Faker::Internet.email,
      password: 'test',
      password_confirmation: 'test',
      admin: false
    }
    User.new(defaults.merge(overrides))
  end

  def create_user(overrides = {})
    new_user(overrides).tap(&:save!)
  end


  def new_project(overrides = {})
    defaults = {
      name: Faker::Company.name,
    }
    Project.new(defaults.merge(overrides))
  end

  def create_project(overrides = {})
    new_project(overrides).tap(&:save!)
  end


  def new_task(overrides = {})
    defaults = {
      description: Faker::Lorem.sentence(3),
      due_date: Date.today + 1.year,
      project: create_project
    }
    Task.new(defaults.merge(overrides))
  end

  def create_task(overrides = {})
    new_task(overrides).tap(&:save!)
  end


  def new_membership(overrides = {})
    defaults = {
      user: create_user,
      project: create_project,
      title: 'Member',
    }
    Membership.new(defaults.merge(overrides))
  end

  def create_membership(overrides = {})
    new_membership(overrides).tap(&:save)
  end

  def sign_in
    user = create_user(
    first_name: 'John',
    last_name: 'Smith',
    password: 'test',
    password_confirmation: 'test',
    email: 'john@example.com',
    )
    project = create_project(
    name: 'Test Project'
    )
    create_membership(
    user: user,
    project: project,
    title: 'Owner',
    )
    visit home_path
    click_on "Sign In"
    fill_in "Email", with: "john@example.com"
    fill_in "Password", with: "test"
    within(".well") do
      click_on "Sign In"
    end
  end

end
