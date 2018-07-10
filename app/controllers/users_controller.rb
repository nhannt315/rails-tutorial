class UsersController < ApplicationController
  before_action :logged_in_user, only: [:edit, :update, :index, :destroy]
  before_action :correct_user, only: [:edit, :update]
  before_action :admin_user, only: :destroy
  before_action :get_user, only: [:index, :show, :update, :destroy]

  def index
    @users = User.get_activated.paginate page: params[:page]
  end

  def show
    redirect_to root_url if @user.nil?
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new user_params
    if @user.save
      flash[:success] = I18n.t("greeting")
      redirect_to @user
    else
      render :new
    end
  end

  def edit; end

  def update
    if @user.update_attributes user_params
      flash[:success] = I18n.t "users.profile_updated"
      redirect_to @user
    else
      render :edit
    end
  end

  def destroy
    @user.destroy
    flash[:success] = "User deleted"
    redirect_to users_url
  end

  private

  def user_params
    params.require(:user).permit :name, :email, :password,
      :password_confirmation
  end

  def logged_in_user
    return if logged_in?
    store_location
    flash[:danger] = I18n.t "log_in.require"
    redirect_to login_url
  end

  # Confirm the correct user
  def correct_user
    get_user
    redirect_to root_url unless current_user? @user
  end

  # Confirm an admin user
  def admin_user
    redirect_to root_url unless current_user.admin?
  end

  def get_user
    @user = User.find_by id: params[:id]
  end
end
