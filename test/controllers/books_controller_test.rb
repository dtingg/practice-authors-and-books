require "test_helper"

describe BooksController do
  it "can render the index" do
    get "/books"
    must_respond_with :success
  end
end
