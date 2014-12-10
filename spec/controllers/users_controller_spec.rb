require 'rails_helper'

describe UsersController do

  before do
    @user = create_user
    @updated_user = {
      user: {
        first_name: 'UpdatedFirst',
        last_name: 'UpdatedLast',
        email: @user.email,
      },
      id: @user.id
    }
    @admin = create_user(admin: true)
  end

  describe '#index' do

    it "renders index if user is logged in" do
      session[:user_id] = @user.id
      get :index
      expect(response.status).to eq(200)
    end

  end

  describe '#create' do

    context 'invalid attempts' do
      it "renders 404 if user is not an admin" do
        session[:user_id] = @user.id
        post :create, :user => {
          first_name: Faker::Name.first_name,
          last_name: Faker::Name.last_name,
          email: Faker::Internet.email,
          password: 'test',
          password_confirmation: 'test',
          admin: false
        }
        expect(response.status).to eq(404)
      end
    end

    context 'valid attempts' do
      it "renders new if user is an admin and creation is unsuccessful" do
        session[:user_id] = @admin.id
        post :create, :user => {
          first_name: "",
          last_name: Faker::Name.last_name,
          email: Faker::Internet.email,
          password: 'test',
          password_confirmation: 'test',
          admin: false
        }
        expect(response).to render_template('new')
      end

      it "redirects to users path if user is an admin" do
        session[:user_id] = @admin.id
        post :create, :user => {
          first_name: Faker::Name.first_name,
          last_name: Faker::Name.last_name,
          email: Faker::Internet.email,
          password: 'test',
          password_confirmation: 'test',
          admin: false
        }
        expect(response).to redirect_to(users_path)
      end
    end

  end


  describe '#new' do

    context 'invalid attempts' do
      it 'renders 404 if user is not an admin' do
        session[:user_id] = @user.id
        get :new
        expect(response.status).to eq(404)
      end
    end

    context 'valid attempts' do
      it 'renders the new user view if user is an admin' do
        session[:user_id] = @admin.id
        get :new
        expect(response).to render_template('new')
      end
    end

  end


  describe '#edit' do

    context 'invalid attempts to edit' do
      it "renders 404 if user attempts to edit another user" do
        session[:user_id] = @user.id
        get :edit, id: @admin.id
        expect(response.status).to eq(404)
      end
    end

    context 'valid attempts to edit' do
      it "renders edit view if user attempts to edit themselves" do
        session[:user_id] = @user.id
        get :edit, id: @user.id
        expect(response).to render_template('edit')
      end

      it "renders edit view if user is an admin" do
        session[:user_id] = @admin.id
        get :edit, id: @user.id
        expect(response).to render_template('edit')
      end
    end

  end


  describe '#show' do

    it 'renders the show view' do
      session[:user_id] = @user.id
      get :show, id: @user.id
      expect(response).to render_template('show')
    end

  end


  describe '#update' do
  end


  describe '#destroy' do
  end


end
