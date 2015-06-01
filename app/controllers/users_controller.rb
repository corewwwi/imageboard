class UsersController < ApplicationController
  before_action :get_user, only: [:show, :update, :edit, :show_thrs, :show_posts] 
  before_action :authenticate_user!
  before_action do 
    render_404 unless current_user.admin?
  end
  
  def index
    @users = User.all.order(created_at: :desc)
  end

  def show
  end

  def show_thrs
    @thrs = @user.thrs.order(created_at: :desc)
    respond_to do |format|
      format.html
      format.js
    end
  end

  def show_posts
    @posts = @user.posts.order(created_at: :desc).page(params[:page]).per(20)
    respond_to do |format|
      format.html
      format.js
    end
  end

  def edit
  end
  
  def update
    if @user.update(user_params)
      redirect_to users_path
    else
      render action: "edit"
    end
  end

  private

    def get_user
      @user = User.find(params[:id])
    end

    def user_params
      params.require(:user).permit(:username, :status)
    end

    def render_404
      render file: "#{Rails.root}/public/404.html", layout: false, status: 404
    end

end