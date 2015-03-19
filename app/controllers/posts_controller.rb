class PostsController < ApplicationController
    before_action :get_thr, only: [:new, :create]

    def edit
    end
    
    def delete
    end 
    def new
        @post = Post.new
    end

    def create
        @post = Post.new(params[:post].permit(:content))
        @post.thr_id = @thr.id
        @post.created_at = Time.now
        @post.save
        @thr.bump_time = @post.created_at
        redirect_to [@thr.board, @thr]
        #binding.pry
    end 

    private

    def get_thr
        @thr = Thr.find(params[:thr_id])
    end 
end



