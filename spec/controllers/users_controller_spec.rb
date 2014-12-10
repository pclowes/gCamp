require 'rails_helper'

describe UsersController do

  describe '#index' do
    before do
      @user = User.create!(
      first_name: "Joe",
      last_name: "Smith",
      email: "joe@example.com",
      password: "test",
      admin: false
      )
    end

    it "does not allow visitors to visit index page and redirects to sign-in page" do
      get :index
      expect(response.status).to eq(302)
      expect(response).to redirect_to(signin_path)
      expect(flash[:notice]).to eq("You must be logged in to access that action")
    end

    it "allows a user to visit index page" do
      session[:user_id] = @user.id
      get :index
      expect(response.status).to eq(200)
    end

    it "allows a user to visit index page" do
      session[:user_id] = @user.id
      get :index
      expect(response.status).to eq(200)
    end

  end


  describe '#show' do
    before do
      @user = User.create!(
      first_name: "Joe",
      last_name: "Smith",
      email: "joe@example.com",
      password: "test",
      admin: false
      )
    end

    it "does not allow visitors to visit show page and redirects to sign-in page" do
      get :show, id: @user.id
      expect(response.status).to eq(302)
      expect(response).to redirect_to(signin_path)
      expect(flash[:notice]).to eq("You must be logged in to access that action")
    end

    it "does allow signed-in users to visit show page" do
      session[:user_id] = @user.id
      get :show, id: @user.id
      expect(response.status).to eq(200)
    end

  end


  describe '#create' do

    before do
      @user = User.create!(
      first_name: "Joe",
      last_name: "Smith",
      email: "joe@example.com",
      password: "test",
      admin: false
      )
    end

    it "does not allow visitors to create users and redirects to sign-in page" do
      post :create, id: @user.id
      expect(response.status).to eq(302)
      expect(response).to redirect_to(signin_path)
      expect(flash[:notice]).to eq("You must be logged in to access that action")
    end

    it "does not allow signed-in users to create users" do
      session[:user_id] = @user.id
      post :create, :user => {
        first_name: "Jane",
        last_name: "Doe",
        email: "jane@example.com",
        password: "test"}
      expect(response.status).to eq(404)
    end

    it "does allow admin users to create users" do
      @user2 = User.create!(
      first_name: "Jane",
      last_name: "Doe",
      email: "jane@example.com",
      password: "test",
      admin: true
      )
      session[:user_id] = @user2.id
      post :create, :user => {
        first_name: "Jill",
        last_name: "Doe",
        email: "Jill@example.com",
        password: "test"}
        expect(response.status).to eq(302)
        expect(response).to redirect_to(users_path)
        expect(flash[:notice]).to eq("User was successfully created.")
      end

  end


  describe '#edit' do
    before do
      @user1 = User.create!(
      first_name: "Joe",
      last_name: "Smith",
      email: "joe@example.com",
      password: "test",
      admin: false
      )
      @user2 = User.create!(
      first_name: "Jake",
      last_name: "Smith",
      email: "jake@example.com",
      password: "test",
      admin: false
      )
      @admin_user = User.create!(
      first_name: "Jane",
      last_name: "Doe",
      email: "jane@example.com",
      password: "test",
      admin: true
      )
    end

    it "does not allow visitors edit users and redirects to sign-in page" do
      get :edit, id: @user1.id
      expect(response.status).to eq(302)
      expect(response).to redirect_to(signin_path)
      expect(flash[:notice]).to eq("You must be logged in to access that action")
    end

    it "does allow logged-in users to edit themselves" do
      session[:user_id] = @user1.id
      get :edit, id: @user1.id
      expect(response.status).to eq(200)
    end

    it "does not allow logged-in users to edit other users" do
      session[:user_id] = @user1.id
      get :edit, id: @user2.id
      expect(response.status).to eq(404)
    end

    it "does allow admin users to edit other users" do
      session[:user_id] = @admin_user.id
      get :edit, id: @user2.id
      expect(response.status).to eq(200)
    end

  end


  describe '#destroy' do
    before do
      @user1 = User.create!(
      first_name: "Joe",
      last_name: "Smith",
      email: "joe@example.com",
      password: "test",
      admin: false
      )
      @user2 = User.create!(
      first_name: "Jane",
      last_name: "Doe",
      email: "jane@example.com",
      password: "test",
      admin: true
      )
      @admin_user = User.create!(
      first_name: "Jane",
      last_name: "Doe",
      email: "jane@example.com",
      password: "test",
      admin: true
      )
    end

    it "does not allow visitors to delete users and redirects to sign-in page" do
      get :show, id: @user1.id
      expect(response.status).to eq(302)
      expect(response).to redirect_to(signin_path)
      expect(flash[:notice]).to eq("You must be logged in to access that action")
    end

  end


end
