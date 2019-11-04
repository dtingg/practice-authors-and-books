class User < ApplicationRecord
  validates :uid, uniqueness: true, presence: true
  
  def self.build_from_github(auth_hash)
    user = User.new
    user.uid = auth_hash[:uid]
    user.provider = "github"
    user.name = auth_hash["info"]["nickname"]
    user.email = auth_hash["info"]["email"]
    
    # Note that the user has not been saved.
    # We'll choose to do the saving outside of this method
    return user
  end
end
