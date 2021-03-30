class BooksController < ApplicationController
  before_action :authenticate_user!, :new_book
  before_action :correct_user, only: [:edit, :update]


  def create
    @new_book = Book.new(book_params)
    @new_book.user_id = current_user.id
    if @new_book.save
      flash[:success] = 'Book was successfully created'
      redirect_to book_path(@new_book.id)
    else
      @books = Book.all
      @user = current_user
      redirect_to books_path
    end
  end

  def index
    @books = Book.all
    @user = current_user
  end

  def show
    @new_book = Book.new
    @book = Book.find(params[:id])
    @user = @book.user
  end

  def edit
    @book = Book.find(params[:id])
  end

  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
      flash[:success] = 'Book was successfully updated'
      redirect_to book_path(@book.id)
    else
      render :edit
    end
  end

  def destroy
    book = Book.find(params[:id])
    book.destroy
    flash[:success] = 'Book was successfully destroyed.'
    redirect_to books_path
  end

  private

  def new_book
    @new_book = Book.new
  end

  def correct_user
    user = Book.find(params[:id]).user
    if current_user.id != user.id
      redirect_to books_path
    end
  end


  def book_params
    params.require(:book).permit(:title, :body)
  end
end
