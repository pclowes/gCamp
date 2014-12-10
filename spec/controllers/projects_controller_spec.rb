require 'rails_helper'

describe ProjectsController do


  describe "#index" do
    it "does not allow visitors visit index page and redirects to sign-in page" do
      get :index
      expect(response.status).to eq(302)
      expect(response).to redirect_to(signin_path)
      expect(flash[:notice]).to eq("You must be logged in to access that action")
    end

    it "does allow logged-in users to visit index page" do
      @user = User.create!(
      first_name: "Joe",
      last_name: "Smith",
      email: "joe@example.com",
      password: "test",
      admin: false
      )
      session[:user_id] = @user.id
      get :index
      expect(response.status).to eq(200)
    end
  end


  describe "#show" do

    before do
      @user = User.create!(
      first_name: "Joe",
      last_name: "Smith",
      email: "joe@example.com",
      password: "test",
      admin: false
      )
      @project = Project.create!(
      name: "Acme"
      )
    end

    it "does not allow visitors visit show page and redirects to sign-in page" do
      get :show, id: @project.id
      expect(response.status).to eq(302)
      expect(response).to redirect_to(signin_path)
      expect(flash[:notice]).to eq("You must be logged in to access that action")
    end

    it "does not allow signed-in non-member users to visit show page" do
      session[:user_id] = @user.id
      get :show, id: @project.id
      expect(response.status).to eq(404)
    end

    it "does allow project members to visit show page" do
      Membership.create!(
      user: @user,
      project: @project,
      title: 'Member'
      )
      session[:user_id] = @user.id
      get :show, id: @project.id
      expect(response.status).to eq(200)
    end

    it "does allow project owners to visit show page" do
      Membership.create!(
      user: @user,
      project: @project,
      title: 'Owner'
      )
      session[:user_id] = @user.id
      get :show, id: @project.id
      expect(response.status).to eq(200)
    end

    it "does allow admins to visit show page even if they are non-members" do
      @user = User.create!(
      first_name: "Jane",
      last_name: "Doe",
      email: "jane@example.com",
      password: "test",
      admin: true
      )
      session[:user_id] = @user.id
      get :show, id: @project.id
      expect(response.status).to eq(200)
    end

  end


  describe "#create" do

    before do
      @user = User.create!(
      first_name: "Joe",
      last_name: "Smith",
      email: "joe@example.com",
      password: "test",
      admin: false
      )
    end

    it "does not allow visitors to create and redirects to sign-in page" do
      get :create, name: "Test name"
      expect(response.status).to eq(302)
      expect(response).to redirect_to(signin_path)
      expect(flash[:notice]).to eq("You must be logged in to access that action")
    end

    it "does allow signed-in users to create" do
      session[:user_id] = @user.id
      post :create, :project => {name: "Test name"}
      expect(response.status).to eq(302)
      expect(flash[:notice]).to eq("Project was successfully created.")
    end

  end


  describe "#edit" do

    before do
      @user = User.create!(
      first_name: "Joe",
      last_name: "Smith",
      email: "joe@example.com",
      password: "test",
      admin: false
      )
      @project = Project.create!(
      name: "Acme"
      )
      @projects = Project.all
    end

    it "does not allow visitors to edit and redirects to sign-in page" do
      get :edit, id: @project.id
      expect(response.status).to redirect_to(signin_path)
    end

    it "does not allow non-members to edit" do
      session[:user_id] = @user.id
      name = @projects.name

      get :edit, id: @project.id

      expect(response.status).to eq(404)
      expect(name).to eq(@projects.name)
    end

    it "does not allow project-members to edit" do
      session[:user_id] = @user.id
      name = Project.name

      get :edit, id: @project.id

      expect(response.status).to eq(404)
      expect(name).to eq(@projects.name)
    end

    it "allows project owners to edit" do
      Membership.create!(
      user: @user,
      project: @project,
      title: 'Owner'
      )
      session[:user_id] = @user.id
      name = Project.name

      get :edit, id: @project.id
      expect(response.status).to eq(200)
    end

    it "allows admins to edit" do
      @user = User.create!(
      first_name: "Jane",
      last_name: "Doe",
      email: "Jane@example.com",
      password: "test",
      admin: true
      )
      Membership.create!(
      user: @user,
      project: @project,
      title: 'Owner'
      )
      session[:user_id] = @user.id
      name = @projects.name

      get :edit, id: @project.id
      expect(response.status).to eq(200)
    end
  end


  describe "#destroy" do

    before do
      @user = User.create!(
        first_name: "Joe",
        last_name: "Smith",
        email: "joe@example.com",
        password: "test",
        admin: false
      )
      @project = Project.create!(
        name: "Acme"
      )
      @projects = Project.all
    end

    it "does not allow visitors to delete and redirects to sign-in page" do
      get :destroy, id: @project.id
      expect(response.status).to redirect_to(signin_path)
    end

    it "does not allow non-members to delete" do
      session[:user_id] = @user.id
      count = @projects.count

      get :destroy, id: @project.id

      expect(response.status).to eq(404)
      expect(count).to eq(@projects.count)
    end

    it "does not allow project-members to delete" do
      session[:user_id] = @user.id
      count = Project.count

      get :destroy, id: @project.id

      expect(response.status).to eq(404)
      expect(count).to eq(@projects.count)
    end

    it "allows project owners to delete" do
      Membership.create!(
        user: @user,
        project: @project,
        title: 'Owner'
      )
      session[:user_id] = @user.id
      count = Project.count

      get :destroy, id: @project.id
      expect(@projects.count).to eq(count -1)
    end

    it "allows admins to delete" do
      @user = User.create!(
      first_name: "Jane",
      last_name: "Doe",
      email: "Jane@example.com",
      password: "test",
      admin: true
      )
      Membership.create!(
      user: @user,
      project: @project,
      title: 'Owner'
      )
      session[:user_id] = @user.id
      count = @projects.count

      get :destroy, id: @project.id
      expect(@projects.count).to eq(count -1)
    end
  end

end
