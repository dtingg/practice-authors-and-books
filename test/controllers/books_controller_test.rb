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

  describe "create" do
    it "can create a book!" do
      # Arrange
      test_params = {
        book: {
          title: "Cat in the Hat",
          author: "Dr. Seuss",
          description: "Tricksy cat!"
        }
      } 
      # Act
      expect {
        post books_path, params: test_params
        # Assert
      }.must_differ 'Book.count', 1

      new_book = Book.find_by(title: "Cat in the Hat")
      expect(new_book).wont_be_nil


    end
  end

end
