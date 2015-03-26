class BoardsController < ApplicationController
    before_action :get_board, only: [:show, :edit, :update, :destroy]
    
    def index
        @boards = Board.all.order(name: :desc)
    end 

    def show
        @thrs = @board.thrs.order(updated_at: :desc).page params[:page]
    end 

    def new
        @board = Board.new
    end 

    def edit
        
    end

    def create
        @board = Board.new(board_params)
        if @board.save
            redirect_to boards_path
        else
            render action: "new"
        end 
    end 

    def update
        if @board.update(board_params)
            redirect_to boards_path
        else
            render action: "edit"
        end
    end  

    def destroy
        @board.destroy   
        redirect_to boards_path
    end 

    private

    def get_board
        @board = Board.find(params[:id])
    end 

    def board_params
      params.require(:board).permit(:name, :pages_limit, :bumplimit, :description, :terms)
    end
end
