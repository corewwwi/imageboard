class BoardsController < ApplicationController
    before_action :get_board, only: [:show, :edit, :update, :destroy]
    
    def index
        @boards = Board.all
    end 

    def show
        @thrs = @board.thrs.order(:bump_time)
    end 

    def new
        @board = Board.new
    end 

    def edit
        
    end

    def create
        @board = Board.new(params[:board].permit(:name, :pages_limit, :bumplimit, :description, :terms))
        if @board.save
            redirect_to boards_path
        else
            render action: "new"
        end 
    end 
    def update
        if @board.update(params[:board].permit(:name, :pages_limit, :bumplimit, :description, :terms))
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

end
