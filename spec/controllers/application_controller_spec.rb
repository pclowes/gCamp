require 'rails_helper'

describe ApplicationController do

  controller do
    def index
      render nothing: true
    end
  end

  it "redirects visitors to signin path" do
    get :index
    expect(response).to redirect_to(signin_path)
  end

end
