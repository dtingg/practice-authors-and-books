class ApplicationController < ActionController::Base
  before_action :require_login, except: [:index]
  # skip_before_action :require_login, only: [:index]
  
  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end
  
  def require_login
    if current_user.nil?
      flash[:error] = "You must be logged in to view this page"
      redirect_to root_path
    end
  end
  
  def show
    @author = Author.find_by(id: params[:id])
  end
end
