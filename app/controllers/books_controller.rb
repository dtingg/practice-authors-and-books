class BooksController < ApplicationController
  def index
    @books = Book.alpha_books
  end
  
  def show
    book_id = params[:id]
    @book = Book.find_by(id: book_id)
    
    if @book.nil?
      head :not_found
      return
    end
  end
  
  def new
    @book = Book.new
  end
  
  def create
    @book = Book.new(book_params) #instantiate a new book
    
    if @book.save # save returns true if the database insert succeeds
      flash[:success] = "Book added successfully"
      redirect_to root_path # go to the index so we can see the book in the list
      return
    else # save failed :(
      render :new # show the new book form view again
      return
    end
  end
  
  def edit
    @book = Book.find_by(id: params[:id])
    
    if @book.nil?
      head :not_found
      return
    end
  end
  
  def update
    @book = Book.find_by(id: params[:id])
    if @book.update(book_params)
      flash[:success] = "Book updated successfully"
      redirect_to root_path # go to the index so we can see the book in the list
      return
    else # save failed :(
      render :edit # show the new book form view again
      return
    end
  end
  
  def destroy
    book_id = params[:id]
    @book = Book.find_by(id: book_id)
    
    if @book.nil?
      head :not_found
      return
    end
    
    @book.destroy
    
    redirect_to books_path
    return
  end
  
  private
  
  def book_params
    return params.require(:book).permit(
      :author_id, :title, 
      :description, :publication_date
    )
  end
  
end
