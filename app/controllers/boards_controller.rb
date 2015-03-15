class BoardsController < ApplicationController
	def index
		@boards = Board.all
	end	

	def show
		@board = Board.find(params[:id])
		@thrs = @board.thrs
		
	end	

	def new
		@board = Board.new
	end	

	def create
		@board = Board.new(params[:id].permit(:name, :pages_limit, :bumplimit, :description, :terms))
		@board.save
	end	

end
