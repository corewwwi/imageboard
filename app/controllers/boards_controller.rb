class BoardsController < ApplicationController
  before_action :get_board, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, except: [:show]
  before_action  except: [:show]  do
    render_404 unless current_user.admin?
  end

  def index
    @boards = Board.all.order(name: :desc)
  end

  def show
    @thrs = @board.thrs.order(updated_at: :desc).page params[:page]
  end

  def new
    @board = Board.new
  end

  def create
    @board = Board.new(board_params)
    if @board.save
      flash[:notice] = "Board successfully created"
      redirect_to boards_path
    else
      render action: "new"
    end
  end

  def edit
  end

  def update
    if @board.update(board_params)
      flash[:notice] = "Board successfully updated"
      redirect_to boards_path
    else
      render action: "edit"
    end
  end

  def destroy
    @board.destroy
    flash[:notice] = "Board successfully destroyed"
    redirect_to boards_path
  end

  private

    def get_board
      @board = Board.find_by(name: params[:name])
    end

    def board_params
      params.require(:board).permit(:name, :pages_limit, :bumplimit, :description, :terms)
    end

    def render_404
      render file: "#{Rails.root}/public/404.html", layout: false, status: 404
    end

end