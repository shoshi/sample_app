class UsersController < ApplicationController
  before_filter :authenticate, :only  =>  [:index, :edit, :update, :destroy]
  before_filter :correct_user, :only  =>  [:edit, :update]
  before_filter :admin_user,   :only  =>  :destroy

  def index
    @title = "All users"
    @users = User.paginate(:page => params[:page])
  end

  def show
    @user = User.find(params[:id])
    @microposts = @user.microposts.paginate(:page => params[:page])
    @title = @user.name
  end

  def new
    @user = User.new
    @title = "Sign up"
    redirect_to root_path if signed_in?
  end

  def create
    @user = User.new(params[:user])
    redirect_to root_path if signed_in?
    if @user.save
      sign_in @user
      flash[:success] = "Welcome to the Sample App!"
      redirect_to @user
    else
      @title = "Sign up"
      render 'new'
      #doesn't work, find a way to clear password fields on error
      @user.password = ""
      @user.password_confirmation = nil
    end
  end

  def edit
    @title = "Edit user"
  end

  def update
    if @user.update_attributes(params[:user])
      flash[:success] = "Profile updated!"
      redirect_to @user
    else
      @title = "Edit user"
      render 'edit'
    end
  end

  def destroy
    if current_user?(User.find(params[:id])) && current_user.admin?
      flash[:error] = "Oh noes! You can't delete yourself!"
    else
      User.find(params[:id]).destroy
      flash[:success] = "User destroyed."
    end
    redirect_to users_path
  end

  private

    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_path) unless current_user?(@user)
    end

    def admin_user
      redirect_to(root_path) unless current_user.admin?
    end
end