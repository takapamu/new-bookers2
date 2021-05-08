class UsersController < ApplicationController
  before_action :ensure_correct_user, only: [:update, :edit, :destroy]
   before_action :authenticate_user!

  def show
      @user = User.find(params[:id])
      @books = @user.books
      @book = Book.new
  end

  def index
      @users = User.all
      @book = Book.new
  
  end

  def edit
      @user = User.find(params[:id])
  if  @user == current_user
      render "edit"
  else
      redirect_to user_path(current_user)
  end
  
  end

  def update
       @user = User.find(params[:id])
    if @user.update(user_params)
       redirect_to user_path(current_user), notice: "You have updated user successfully."
    else
       render "edit"
    end
  end
  
  def followings
      @user = User.find(params[:id])
      @followings = @user.following_users
  end

  def followers
      @user = User.find(params[:id])
      @followers = @user.follower_users
  end

  private
  def user_params
      params.require(:user).permit(:name,:profile_image,:introduction,:postcode, :prefecture_code, :address_city, :address_street)
  end
  
   def set_user
      @user = User.find(params[:id])
   end

  def ensure_correct_user
      @user = User.find(params[:id])
   unless @user == current_user
      redirect_to user_path(current_user)
   end
  end
end
