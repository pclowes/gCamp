class SecureController < ApplicationController
  before_action :require_login
end
