require 'rails_helper'

describe ProjectsController do

  before do
    @user = User.create!(
    first_name: "Jill",
    last_name: "Smith",
    email: "jill@example.com",
    password: "test",
    admin: false
    )

    @member_user = User.create!(
    first_name: "Joe",
    last_name: "Smith",
    email: "joe@example.com",
    password: "test",
    admin: false
    )

    @owner_user = User.create!(
    first_name: "Jake",
    last_name: "Smith",
    email: "jake@example.com",
    password: "test",
    admin: false
    )

    @admin_user = User.create!(
    first_name: "Jane",
    last_name: "Doe",
    email: "Jane@example.com",
    password: "test",
    admin: true
    )

    @project = Project.create!(
    name: "Project Name"
    )

    @updated_project = {
      project: {
        name: "Updated Project Name"
      },
      id: @project.id
    }

    @projects = Project.all

    Membership.create!(
    user: @owner_user,
    project: @project,
    title: 'Owner'
    )

    Membership.create!(
    user: @member_user,
    project: @project,
    title: 'Member'
    )

  end


  describe "#index" do

    it "renders the index view for logged-in users" do
      session[:user_id] = @user.id
      get :index
      expect(response.status).to render_template('index')
    end

  end


  describe "#create" do

    before do
      session[:user_id] = @user.id
    end

    it "redirects to project tasks when signed-in users successfully save" do
      post :create, :project => {name: "Test name"}
      expect(response).to redirect_to(project_tasks_path(@projects.last))
    end

    it "renders new view on unsuccessful save" do
      post :create, :project => {name: ""}
      expect(response).to render_template('new')
    end

  end


  describe "#new" do

    it "renders the new project view" do
      session[:user_id] = @user.id
      get :new
      expect(response).to render_template('new')
    end

  end


  describe "#edit" do

    context "invalid attempts to edit" do
      it "renders 404 if user is not a member" do
        session[:user_id] = @user.id
        get :edit, id: @project.id
        expect(response.status).to eq(404)
      end

      it "renders 404 if user is not a owner" do
        session[:user_id] = @member_user.id
        get :edit, id: @project.id
        expect(response.status).to eq(404)
      end
    end

    context "valid attempts to edit" do
      it "renders edit view if user is an owner" do
        session[:user_id] = @owner_user.id
        name = Project.name
        get :edit, id: @project.id
        expect(response).to render_template('edit')
      end

      it "renders edit view if user is an admin" do
        session[:user_id] = @admin_user.id
        name = @projects.name
        get :edit, id: @project.id
        expect(response).to render_template('edit')
      end
    end

  end


  describe "#show" do

    context "invalid attempts to view" do
      it "renders 404 if user is not associated" do
        session[:user_id] = @user.id
        get :show, id: @project.id
        expect(response.status).to eq(404)
      end
    end

    context "valid attempts to view" do
      it "renders the show view if user is a member" do
        session[:user_id] = @member_user.id
        get :show, id: @project.id
        expect(response).to render_template('show')
      end

      it "renders the show view if user is an owner" do
        session[:user_id] = @owner_user.id
        get :show, id: @project.id
        expect(response).to render_template('show')
      end

      it "renders the show view if user is an admin" do
        session[:user_id] = @admin_user.id
        get :show, id: @project.id
        expect(response).to render_template('show')
      end
    end

  end


  describe "#update" do

    context 'invalid attempts to update' do
      it 'renders 404 if user is not associated' do
        session[:user_id] = @user
        put :update, @updated_project
        expect(response.status).to eq(404)
      end

      it 'renders 404 if user is a member' do
        session[:user_id] = @member_user
        put :update, @updated_project
        expect(response.status).to eq(404)
      end
    end

    context 'valid attempts to update' do
      it 'renders edit view on unsuccessful update' do
        session[:user_id] = @owner_user
        updated_project = {
          project: {
            name: ''
          },
          id: @project
        }
        put :update, updated_project
        expect(response).to render_template('edit')
      end

      it 'redirects to project path on successful update' do
        session[:user_id] = @owner_user
        put :update, @updated_project
        expect(response).to redirect_to(project_path(Project.first))
      end

      it 'redirects to project path if user is an admin' do
        session[:user_id] = @admin_user
        put :update, @updated_project
        expect(response).to redirect_to(project_path(Project.first))
      end
    end

  end


  describe "#destroy" do

    context "invalid attempts to destroy" do
      it "renders 404 if user is not associated" do
        session[:user_id] = @user.id
        count = @projects.count
        delete :destroy, id: @project.id
        expect(response.status).to eq(404)
        expect(count).to eq(@projects.count)
      end

      it "renders 404 if user is a member" do
        session[:user_id] = @member_user.id
        count = Project.count
        delete :destroy, id: @project.id
        expect(response.status).to eq(404)
        expect(count).to eq(@projects.count)
      end
    end

    context "valid attempts to destroy" do
      it "redirects to projects path if user is an owner" do
        session[:user_id] = @owner_user.id
        count = Project.count
        delete :destroy, id: @project.id
        expect(@projects.count).to eq(count -1)
        expect(response).to redirect_to(projects_path)
      end

      it "redirects to projects path if user is an admin" do
        session[:user_id] = @admin_user.id
        count = @projects.count
        delete :destroy, id: @project.id
        expect(@projects.count).to eq(count -1)
        expect(response).to redirect_to(projects_path)
      end
    end

  end


end
