class BooksController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_correct_user, only: [:edit]

  def ensure_correct_user
    @book = Book.find(params[:id])
    if @book.user_id != current_user.id
        redirect_to books_path
    end
  end

  def index
  	@books = Book.all
  	@book = Book.new
    @user = current_user
    @users = User.all
  end

  def show
  	@book_new = Book.new
    @book = Book.find(params[:id])
  end

  def new
  	@book = Book.new
    @book = current_user.id
    if @book.save
       flash[:new] = "successfully"
       redirect_to book_path(@book.id)
    else
      @books = Book.all
      @user = current_user
      @users = User.all
      flash[:no] = "error"
      render :index
    end
  end

  def edit
  	@book = Book.find(params[:id])
  end

  def create
  	@book = Book.new(book_params)
    @book.user_id = current_user.id
  	if @book.save
  	   flash[:info] = "successfully"
  	   redirect_to book_path(@book.id)
  	else
      @books = Book.all
      @user = current_user
      @users = User.all
      flash[:notice] = "error"
  		render :index
  	end
  end

  def update
  		@book = Book.find(params[:id])
     if @book.update(book_params)
  		flash[:info] = "successfully"
  		redirect_to book_path
  	else
      @books = Book.all
      @user = current_user
      @users = User.all
      flash[:notice] = "error"
      render :index
  	end
  end

  def destroy
  		book = Book.find(params[:id])
  		book.destroy
  		redirect_to books_path
  end

  private
  def book_params
  	params.require(:book).permit(:title, :body)
  end
end