class ThrsController < ApplicationController
    before_action :get_board, except: [:most, :index]
    before_action :get_thr, only: [:show, :destroy], except: [:most]

    def most
        @thrs = Thr.all.order(:bump_time)
    end    

    def index
       
    end 

    def show
        @thr = Thr.find(params[:id])
        @posts = @thr.posts.where(op: false) 
        @op_post = @thr.posts.where(op: true)
        @post = Post.new
    end 

    def new
        @thr = Thr.new
    end 
    
    def create
        @thr = Thr.new(params[:thr].permit(:title))
        @thr.board_id = @board.id
        @thr.bump_time = Time.now
        @thr.save

        @post = Post.new(params.permit(:content))
        @post.created_at = Time.now
        @post.thr_id = @thr.id
        @post.op = true
        if @post.save
            redirect_to [@board, @thr]
        else
            render action: “new”
        end      
    end 

    def destroy
        @thr.destroy
        redirect_to [@board]
    end 

    private

    def get_board
        @board = Board.find(params[:board_id])
    end   

    def get_thr
        @thr = Thr.find(params[:id]) 
    end
end
