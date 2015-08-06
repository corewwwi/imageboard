class ThrsController < ApplicationController
  before_action :get_board, except: [:most, :index]
  before_action :get_thr, only: [:show, :destroy, :edit, :update]
  after_action :destroy_old_thr, only: [:new, :create]
  before_action :authenticate_user!, except: [:most, :show]
  # before_action only: [:destroy, :edit, :update] do
  #   render_500 unless current_user.admin?
  # end
  # before_action only: [:create] do
  #   render_500 if current_user.banned?
  # end
  load_and_authorize_resource 
  skip_authorize_resource :only => [:most, :index, :show]

  def most
    @thrs = Thr.all.order(updated_at: :desc).limit(10)
  end

  def index
  end

  def show
    @posts = @thr.posts.order(:created_at)
    @post = Post.new
  end

  def new
    @thr = Thr.new
    @thr.posts.build(params[:post])
  end

  def create
    @thr = Thr.new(thr_params)
    @thr.board = @board
    @thr.user = current_user
    if @thr.save
      flash[:notice] = "Thread successfully created"
      redirect_to [@board, @thr]
    else
      render action: 'new'
    end
  end

  def edit
  end

  def update
    if @thr.update(params[:thr].permit(:title))
      flash[:notice] = "Thread successfully updated"
      redirect_to [@board, @thr]
    else
      render action: "edit"
    end
  end

  def destroy
    @thr.destroy
    flash[:notice] = "Thread successfully destroyed"
    redirect_to [@board]
  end

  private

    def destroy_old_thr
      while @board.thrs.count > @board.pages_limit * 5
        last_thr = @board.thrs.order(updated_at: :desc).last
        last_thr.destroy
      end
    end

    def get_board
      @board = Board.find_by(name: params[:board_name])
    end

    def get_thr
      @thr = Thr.find(params[:id])
    end

    def thr_params
      params.require(:thr).permit(:title, posts_attributes: [:content, :pic, :anon, :youtube_video, :user_id])
    end

    def render_404
      render file: "#{Rails.root}/public/404.html", layout: false, status: 404
    end
end