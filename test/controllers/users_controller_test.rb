require "test_helper"

describe UsersController do
  before do
    User.create!(username: "devin")
  end
  
  describe "current" do
    it "sets session[:user_id], redirects, and responds with success" do
      # Arrange
      user = perform_login
      
      # Act 
      get current_user_path
      
      # Assert 
      must_respond_with :success
    end
    
    it "sets flash[:error] and redirects when there's no user" do
      # Act 
      get current_user_path
      
      #Assert
      expect(flash[:error]).must_equal "You must be logged in to view this page"
      must_redirect_to root_path
    end
  end
  
  describe "auth_callback" do
    it "logs in an existing user" do
      start_count = User.count
      user = users(:grace)
      
      perform_login(user)
      must_redirect_to root_path
      session[:user_id].must_equal  user.id
      
      # Should *not* have created a new user
      User.count.must_equal start_count
    end
    
    
    it "creates an account for a new user and redirects to the root route" do
    end
    
    it "redirects to the login route if given invalid user data" do
    end
    
    
    it "creates a new user" do
      start_count = User.count
      user = User.new(provider: "github", uid: 99999, name: "test_user", email: "test@user.com")
      
      OmniAuth.config.mock_auth[:github] = OmniAuth::AuthHash.new(mock_auth_hash(user))
      get auth_callback_path(:github)
      
      must_redirect_to root_path
      
      # Should have created a new user
      User.count.must_equal start_count + 1
      
      # The new user's ID should be set in the session
      session[:user_id].must_equal User.last.id
    end
    
    
  end
end