require "rails_helper"

RSpec.describe PagesController, :type => :controller do

  describe "GET #faq" do
    context "login admin" do
      login_admin
      before (:example) do
        get :faq 
      end  
      it "has a 200 status code" do
        expect(response.status).to eq(200)
      end
      it "renders 'faq' template" do
        expect(response).to render_template('faq')
      end 
    end 
    context "login user" do
      login_user
      before (:example) do
        get :faq 
      end  
      it "has a 200 status code" do
        expect(response.status).to eq(200)
      end
      it "renders 'faq' template" do
        expect(response).to render_template('faq')
      end 
    end 
    context "login banned user" do
      login_banned
      before (:example) do
        get :faq 
      end  
      it "has a 200 status code" do
        expect(response.status).to eq(200)
      end
      it "renders 'faq' template" do
        expect(response).to render_template('faq')
      end 
    end
  end

end  