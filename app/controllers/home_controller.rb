class HomeController < ApplicationController
  skip_before_filter :authorize
  def index
    redirect_to workspaces_url
    if params[:set_locale]
      redirect_to home_path(:locale => params[:set_locale])
    end

  end
end