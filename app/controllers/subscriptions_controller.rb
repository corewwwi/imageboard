class SubscriptionsController < ApplicationController
  before_action :get_thr
  before_action :authenticate_user!
  load_and_authorize_resource

  def create
    @subscription = Subscription.create(user: current_user, thr: @thr)
    if @subscription.persisted?
      respond_to do |format|
        format.html { render :create }
        format.js { render :create }
      end
    end  
  end 

  def destroy
    if @subscription = Subscription.find_by(user: current_user, thr: @thr)
      @subscription.destroy
      if @subscription.destroyed?
        respond_to do |format|
          format.html { render :destroy }
          format.js { render :destroy }
        end
      end  
    else
      render_404  
    end  
  end 

  private

  def get_thr
    @thr = Thr.find(params[:thr_id])
  end

end
