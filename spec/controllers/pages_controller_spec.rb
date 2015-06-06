require "rails_helper"

RSpec.describe PagesController, :type => :controller do

  describe "GET #faq" do

    shared_examples "allows access" do
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