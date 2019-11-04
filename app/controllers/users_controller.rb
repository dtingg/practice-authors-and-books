class UsersController < ApplicationController
  # app/controllers/users_controller.rb
  
  def current
    @user = User.find_by(id: session[:user_id])
    if @user.nil?
      head :not_found
      return
    end 
  end
  
  def create
    auth_hash = request.env["omniauth.auth"]
    
    user = User.find_by(uid: auth_hash[:uid], provider: params[:provider])
    if user
      flash[:success] = "Logged in as returning user #{user.name}"
    else
      user = User.build_from_github(auth_hash)
      if user.save
        flash[:success] = "Logged in as new user #{user.name}"
      else
        flash[:error] = "Could not create new user account: #{user.errors.messages}"
        return redirect_to root_path
      end
    end
    
    # If we get here, we have a valid user instance
    session[:user_id] = user.id
    return redirect_to root_path
  end
  
  def destroy
    session[:user_id] = nil
    flash[:success] = "Successfully logged out!"
    redirect_to root_path
  end
  
end
