class UsersController < ApplicationController
	before_action :get_user, only: [:edit, :update] 

    def index
        @users = User.all
    end

    def edit

    end
    
    def update
    	if @user.update(user_params)
            redirect_to users_path
        else
            render action: "edit"
        end
    end

    private

    def get_user
    	@user = User.find(params[:id])
    end	

    def user_params
    	params.require(:user).permit(:email, :banned, :admin)
    end	
end
