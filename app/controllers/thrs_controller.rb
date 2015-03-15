class ThrsController < ApplicationController
	def index
		
	end	
	def show
		@thr = Thr.find(params[:id])
		@posts = @thr.posts.where(op: false) 
		@op_post = @thr.posts.where(op: true)
	end	
end
