require 'rails_helper'

describe ProjectsController do

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

end
