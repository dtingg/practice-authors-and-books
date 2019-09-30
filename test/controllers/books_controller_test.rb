require "test_helper"

describe BooksController do

  describe "Index" do
    it "can render the index" do
      get "/books"
      must_respond_with :success
    end
  end

  describe "Show" do
    it "can render an extant book" do
      get "/books/1"
      must_respond_with :success
    end

    it "responds 'not found' for an non-existant book" do
      get "/books/5000000"
      must_respond_with :error
    end
  end

end
