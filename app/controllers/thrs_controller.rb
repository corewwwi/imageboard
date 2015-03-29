class ThrsController < ApplicationController
    before_action :get_board, except: [:most, :index]
    before_action :get_thr, only: [:show, :destroy]
    after_action :destroy_old_thr, only: [:create]
    before_action :authenticate_user!, except: [:most, :show]
    before_action only: [:destroy] do 
        render_404 unless current_user.admin?
    end
    before_action only: [:new, :create] do 
        render_404 if current_user.banned?
    end

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
        

        @post = Post.new(params.permit(:content, :pic, :anon))
        
        @post.user_id = current_user.id
        @post.op = true
        @post.content = nil if @post.content.scan(/\S/).size == 0
        
        @thr.save_with_post(@post) 

        redirect_to [@board, @thr]
             
    end 

    def destroy
        @thr.destroy
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
        @board = Board.find(params[:board_id])
    end   

    def get_thr
        @thr = Thr.find(params[:id]) 
    end

    def render_404
        render file: "#{Rails.root}/public/404.html", layout: false, status: 404
    end
end
