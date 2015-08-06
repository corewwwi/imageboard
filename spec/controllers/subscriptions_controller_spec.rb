require 'rails_helper'

RSpec.describe SubscriptionsController, type: :controller do

  describe 'POST #create', broken: true do
    let (:thr) { create (:thr) }
    let (:subscription) { attributes_for(:subscription) }

    shared_examples "allows access" do

      it "creates a new subscription" do 
        expect{ post :create, subscription: subscription }.to change(Subscription,:count).by(1) 
      end 
      it "renders 'subscribe' template" do 
        post :create, subscription: subscription, format: "js"
        expect(response).to render_template('subscribe')
      end 
      it "assign @subscription not no be nil" do
        expect(assigns['subscription']).not_to be_nil
      end

    end

    context "when login admin" do
      login_admin
      it_behaves_like "allows access" 
    end 

    context "when login user" do
      login_user
      it_behaves_like "allows access" 
    end 

    context "when login banned user" do
      login_banned
      it_behaves_like "allows access" 
    end

  end

end
