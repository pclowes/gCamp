require 'rails_helper'

describe MembershipsController do

  before do
    @user = create_user
    @member = create_user
    @owner = create_user
    @admin = create_user(admin: true)
    @project = create_project
    @updated_project = {
      project: {
        name: 'Updated Project Name'
      },
      id: @project.id
    }
    @projects = Project.all
    @membership = create_membership(
      user: @member,
      project: @project,
      title: 'Member'
    )
    @ownership = create_membership(
      user: @owner,
      project: @project,
      title: 'Owner'
    )
  end


  describe '#index' do

    context 'invalid access attempts' do
      it 'renders 404 if user is not a member' do
        session[:user_id] = @user.id
        get :index, project_id: @project.id
        expect(response.status).to eq(404)
      end
    end

    context 'valid access attempts' do
      it 'renders index view if user is a member' do
        session[:user_id] = @member.id
        get :index, project_id: @project.id
        expect(response).to render_template('index')
      end

      it 'renders index view if user is an owner' do
        session[:user_id] = @owner.id
        get :index, project_id: @project.id
        expect(response).to render_template('index')
      end

      it 'renders index view if user is an admin' do
        session[:user_id] = @admin.id
        get :index, project_id: @project.id
        expect(response).to render_template('index')
      end
    end

  end


  describe '#create' do
    context 'invalid create attempts' do
      it 'renders 404 if user is a non-member' do
        session[:user_id] = @user.id
        post :create, project_id: @project, membership_id: @membership
        expect(response.status).to eq(404)
      end

      it 'renders 404 if user is a member' do
        session[:user_id] = @member.id
        post :create, project_id: @project, membership_id: @membership
        expect(response.status).to eq(404)
      end
    end

    context 'valid create attempts' do
      it 'renders index if owner save fails' do
        session[:user_id] = @owner.id
        post :create, project_id: @project.id, :membership => {user: '', title: "Owner"}
        expect(response).to render_template('index')
      end

      it 'renders index if admin save fails' do
        session[:user_id] = @admin.id
        post :create, project_id: @project.id, membership: {user: '', title: "Owner"}
        expect(response).to render_template('index')
      end

      it 'redirects to memberships index if user is an owner' do
        session[:user_id] = @owner.id
        post :create, project_id: @project.id, :membership => {project_id: @project.id, user_id: @user, title: "Owner"}
        expect(response).to redirect_to(project_memberships_path(@project))

      end

      it 'redirects to memberships index if user is an admin' do
        session[:user_id] = @admin.id
        post :create, project_id: @project.id, :membership => {project_id: @project.id, user_id: @user, title: "Owner"}
        expect(response).to redirect_to(project_memberships_path(@project))
      end
    end

  end


  describe '#update' do

    context 'invalid access attempts' do
      it 'renders 404 if user is a non-member' do
        session[:user_id] = @user.id
        put :update, project_id: @project.id, id: @member.id, membership: 'Owner'
        expect(response.status).to eq(404)
      end

      it 'renders 404 if user is a member' do
        session[:user_id] = @member.id
        put :update, project_id: @project.id, id: @member.id, membership: 'Owner'
        expect(response.status).to eq(404)
      end
    end

    context 'valid access attempts' do
      it 'renders index if owner save is unsuccessful' do
        session[:user_id] = @owner.id
        put :update, project_id: @project.id, id: @ownership.id, membership: {title: ''}
        expect(response).to render_template('index')
      end

      it 'renders index if admin save is unsuccessful' do
        session[:user_id] = @admin.id
        put :update, project_id: @project.id, id: @membership.id, membership: {title: ''}
        expect(response).to render_template('index')
      end

      it 'redirects to index if owner save is successful' do
        session[:user_id] = @owner.id
        put :update, project_id: @project.id, id: @membership.id, membership: {title: 'Owner'}
        expect(response).to redirect_to(project_memberships_path(@project))
      end

      it 'redirects to index if admin save is successful' do
        session[:user_id] = @admin.id
        put :update, project_id: @project.id, id: @membership.id, membership: {status: 'Owner'}
        expect(response).to redirect_to(project_memberships_path(@project))
      end
    end

  end


  describe '#destroy' do

    context 'invalid access attempts' do
      it 'renders 404 if member deletes other member' do
        session[:user_id] = @member.id
        delete :destroy, project_id: @project.id, id: @ownership.id
        expect(response.status).to eq(404)
      end

      it 'renders 404 if non member/owner/admin deletes' do
        session[:user_id] = @user.id
        delete :destroy, project_id: @project.id, id: @membership.id
        expect(response.status).to eq(404)
      end

      it 'redirects to project memberships if the last owner is deleted' do
        session[:user_id] = @admin.id
        delete :destroy, project_id: @project.id, id: @ownership.id
        expect(response).to redirect_to(project_memberships_path)
      end
    end

    context 'valid access attempts' do
      it 'redirects to index if owner deletes other member' do
        session[:user_id] = @owner.id
        delete :destroy, project_id: @project.id, id: @membership.id
        expect(response).to redirect_to(project_memberships_path(@project))
      end

      it 'redirects to index if admin deletes member' do
        session[:user_id] = @admin.id
        delete :destroy, project_id: @project.id, id: @membership.id
        expect(response).to redirect_to(project_memberships_path(@project))
      end

      it 'redirects to projects if member deletes self' do
        session[:user_id] = @member.id
        delete :destroy, project_id: @project.id, id: @membership.id
        expect(response).to redirect_to(projects_path)
      end
    end

  end


end
