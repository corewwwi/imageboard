class ThrsController < ApplicationController
    before_action :get_board, except: [:most, :index]
    before_action :get_thr, only: [:show, :destroy]
    after_action :destroy_old_thr, only: [:create]
    def most
        @thrs = Thr.all.order(updated_at: :desc).limit(10)
    end    

    def index
       
    end 

    def show
        @posts = @thr.posts
        @simple_posts = @posts.simple_posts
        @op_post = @posts.op_post
        @post = Post.new
    end 

    def new
        @thr = Thr.new
    end 
    
    def create
        @thr = Thr.new(params[:thr].permit(:title))
        @thr.board_id = @board.id
        @thr.save

        @post = Post.new(params.permit(:content, :pic, :anon))
        @post.thr_id = @thr.id
        @post.user_id = current_user.id
        @post.op = true
        
        if  @post.save#thr_save(@thr, @post)

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

    def destroy_old_thr
        while @board.thrs.count > @board.pages_limit * 5
            last_thr = @board.thrs.order(updated_at: :desc).last
            last_thr.posts.each do |post|
                post.destroy
            end
            last_thr.destroy      
        end  
    end    

    def get_board
        @board = Board.find(params[:board_id])
    end   

    def get_thr
        @thr = Thr.find(params[:id]) 
    end
end
