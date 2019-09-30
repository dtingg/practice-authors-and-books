require "test_helper"

describe BooksController do

  describe "Index" do
    it "can render the index" do
      get "/books"
      must_respond_with :success
    end
  end
  
end
