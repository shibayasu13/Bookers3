class UsersController < ApplicationController
	before_action :authenticate_user!
  before_action :ensure_correct_user , only:[:edit]

	def index
		@book = Book.new
    @user = current_user
    @users = User.all
	end

  def show
    @users = User.all
    @user = User.find(params[:id])
    @book = Book.new
  end

  def edit
  	@user = User.find(params[:id])
  end
  def update
  	@user = User.find(params[:id])
  	@user.update(user_params)
    if @user.save
       flash[:info] = "successfully"
       redirect_to user_path(@user.id)
    else
      @users = User.all
      flash[:notice] = "error"
      render :edit
    end
  end

  def create
  	@book = Book.new(book_params)
    @book.user_id = current_user.id
  	if @book.save
  	   flash[:info] = "succsesfully"
  	   redirect_to books_path(@book.id)
  	else@book = Book.all
      @user = current_user
      @users = User.all
      flash[:notice] = "error"
      render :index
    end
  end

  def ensure_correct_user
    @user = User.find(params[:id])
    if @user.id != current_user.id
        redirect_to user_path(current_user)
    end
  end

  private
  def user_params
  	params.require(:user).permit(:name, :profile_image, :introduction)
  end
end