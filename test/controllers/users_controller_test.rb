require "test_helper"

describe UsersController do
  describe "auth_callback" do
    it "logs in an existing user and redirects to the root route" do
      # Count the users, to make sure we're not (for example) creating
      # a new user every time we get a login request
      start_count = User.count
      
      perform_login
      
      must_redirect_to root_path
      
      # Should *not* have created a new user
      _(User.count).must_equal start_count
    end
    
    it "creates an account for a new user and redirects to the root route" do
      # new_user = users(:grace)
      # new_user.uid = 420
      new_user = User.new(name:"Kathy", email: "whatev@git.com", uid: 473837 )
      
      OmniAuth.config.mock_auth[:github] = OmniAuth::AuthHash.new(mock_auth_hash(new_user))
      expect{ get auth_callback_path(:github) }.must_change "User.count", 1
      
      must_redirect_to root_path
      
    end
    
    it "redirects to the login route if given invalid user data" do
      new_user = User.new(name:"Kathy", email: "whatev@git.com", uid: nil )
      
      OmniAuth.config.mock_auth[:github] = OmniAuth::AuthHash.new(mock_auth_hash(new_user))
      expect{ get auth_callback_path(:github) }.wont_change "User.count"
      
      must_redirect_to root_path
    end
  end
  
  describe "current" do
    # it "sets session[:user_id], redirects, and responds with success
    # " do
    #   # Arrange
    #   user = perform_login
    
    #   # Act 
    #   get current_user_path
    
    #   # Assert 
    #   must_respond_with :success
    # end
    
    # it "sets flash[:error] and redirects when there's no user" do
    #   # Act 
    #   get current_user_path
    
    #   #Assert
    #   expect(flash[:error]).must_equal "You must be logged in to see this page"
    #   must_redirect_to root_path
    # end
  end
end
