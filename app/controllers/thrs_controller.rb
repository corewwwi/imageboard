class ThrsController < ApplicationController
    before_action :get_board, except: [:most, :index]
    before_action :get_thr, only: [:show, :destroy, :edit, :update]
    after_action :destroy_old_thr, only: [:new, :create]
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
        @simple_posts = @posts.simple_posts.order(:created_at)
        @op_post = @posts.op_post
        @post = Post.new
    end 

    def new
        @thr = Thr.new
    end 
    
    def create
        @thr = Thr.new(thr_params)
        @thr.board_id = @board.id
        

        @post = Post.new(params.permit(:content, :pic, :anon, :youtube_video))
        
        @post.user_id = current_user.id
        @post.op = true
        @post.content = nil if @post.content.scan(/\S/).size == 0
        
        if @thr.save_with_post(@post) 
            flash[:notice] = "Thread successfully created"
            redirect_to [@board, @thr]
        else
            render action: 'new'    
        end     
    end 

    def edit

    end
    
    def update 
        if @thr.update(thr_params)
            flash[:notice] = "Thread successfully updated"
            redirect_to [@board, @thr]
        else
            render action: "edit"
        end
    end    


    def destroy
        @thr.destroy
        flash[:notice] = "Thread successfully destroyed"
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

    def thr_params
        params.require(:thr).permit(:title)
    end    

    def render_404
        render file: "#{Rails.root}/public/404.html", layout: false, status: 404
    end
end
