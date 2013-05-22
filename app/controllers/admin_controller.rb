class AdminController < ApplicationController
  skip_before_filter :authorize
  before_filter :authorize_admin
  def index
  end
end
