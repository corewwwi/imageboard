class PostsController < ApplicationController
    before_action :get_thr, only: [:new, :create]
    before_action :get_board, only: [:new, :create]
    before_action :authenticate_user!, only: [:new, :create]
    before_action only: [:new, :create] do 
        render_404 if current_user.banned?
    end

    def edit
    end

    def delete
    end 

    def new
        @post = Post.new
    end

    def create
        @post = Post.new(post_params)
        @post.thr_id = @thr.id
        #binding.pry
        @post.user_id = current_user.id

           
        @post.save
        @thr.updated_at = @post.created_at unless (@post.sage || @thr.posts.count > @board.bumplimit)
        @thr.save

        respond_to do |format|
            format.html { redirect_to [@thr.board, @thr] }
            format.js
        end
        
        #binding.pry
    end 

    private

    def get_board
        @board = Board.find(params[:board_id])
    end

    def get_thr
        @thr = Thr.find(params[:thr_id])
    end 

    def post_params
        params.require(:post).permit(:content, :pic, :sage, :anon, :youtube_video)
    end  

    def render_404
        render file: "#{Rails.root}/public/404.html", layout: false, status: 404
    end  
end



