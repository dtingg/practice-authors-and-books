class BooksController < ApplicationController
  before_action :find_book, only: [:show, :edit, :update, :destroy]
  before_action :if_book_missing, only: [:show, :edit, :destroy]
  before_action :require_login, except: [:index]
  # after_action :no_oper, only: [:show, :edit]
  
  def index
    if params[:author_id]
      # This is the nested route, /author/:author_id/books
      author = Author.find_by(id: params[:author_id])
      if author.nil?
        redirect_to authors_path
      end
      
      @books = author.books.alpha_books
      
    else
      # This is the 'regular' route, /books
      @books = Book.alpha_books #Book.all
    end
    
  end
  
  def show ; end
  
  def new
    if params[:author_id]
      # This is the nested route, /author/:author_id/books/new
      author = Author.find_by(id: params[:author_id])
      @book = author.books.new
      
    else
      # This is the 'regular' route, /books/new
      @book = Book.new
    end
  end
  
  def create
    @book = Book.new(book_params) #instantiate a new book
    if @book.save # save returns true if the database insert succeeds
      flash[:success] = "Book added successfully"
      redirect_to root_path # go to the index so we can see the book in the list
      return
    else # save failed :(
      flash.now[:failure] = "Book failed to save"
      render :new, status: :bad_request # show the new book form view again
      return
    end
  end
  
  def edit ; end
  
  def update
    if @book.update(book_params)
      redirect_to root_path # go to the index so we can see the book in the list
      return
    else # save failed :(
      render :edit, status: :bad_request # show the new book form view again
      return
    end
  end
  
  def destroy
    @book.destroy
    
    redirect_to books_path
    return
  end
  
  private
  
  def book_params
    return params.require(:book).permit(:author_id, :title, 
    :description, :publication_date, genre_ids: [])
  end
  
  def find_book
    @book = Book.find_by(id: params[:id])
  end
  
  def if_book_missing
    if @book.nil?
      flash[:warning] = "Book with id #{params[:id]} was not found."
      redirect_to root_path 
      return
    end
  end
  
  # def no_oper
  #   yeahhh = 5+5
  # end
  
end
