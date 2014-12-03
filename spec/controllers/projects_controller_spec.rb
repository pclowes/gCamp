require 'rails_helper'

describe ProjectsController do

  describe "#destroy"

    before do
      @user = User.create!(
        first_name: "Joe",
        last_name: "Smith"
        email: "joe@example.com"
        password: "test"
      )
      @project = Project.create!
        name: "Acme"
      )
    end

    it "does not allow non-members"
      session[:user_id] = @user.id
      count = Project.count

      delete :destroy, id: project.id

      expect(response.status).to eq(404)
      expect(count).to eq(Project.count)
    end

    it "does not allow project-members"
      session[:user_id] = @user.id
      count = Project.count

      delete :destroy, id: project.id

      expect(response.status).to eq(404)
      expect(count).to eq(Project.count)
    end

    it "allows project owners to delete" do
      Membership.create!(
        user: @user,
        project: @project,
        title: 'owner'
      )
      session[:user_id] = @user.id
      count = Project.count

      delete :destroy, id: project.id
      expect(Project.count).to eq(count -1)
    end

    it "allows admins to delete" do
      Membership.create!(
      user: @user,
      project: @project,
      title: 'owner'
      )
      session[:user_id] = @user.id
      count = Project.count

      delete :destroy, id: project.id
      expect(Project.count).to eq(count -1)
    end
