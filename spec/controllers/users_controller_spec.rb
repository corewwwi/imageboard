require "rails_helper"

RSpec.describe UsersController, :type => :controller do

  describe "GET #index" do
    context "login admin" do
      login_admin
      before (:example) do
        get :index 
      end  
      let (:users) { User.all.order(created_at: :desc) }
      it "has a 200 status code" do
        expect(response.status).to eq(200)
      end
      it "renders 'index' template" do
        expect(response).to render_template('index')
      end 
      it "assign all users to @users" do
        expect(assigns['users']).to eq(users)
      end 
    end 
    context "login user" do
      login_user
      before (:example) do
        get :index 
      end  
      it "has a 404 status code" do
        expect(response.status).to eq(404)
      end 
    end 
    context "login banned user" do
      login_banned
      before (:example) do
        get :index 
      end  
      it "has a 404 status code" do
        expect(response.status).to eq(404)
      end 
    end
  end

  describe "GET #show" do
    let (:user) { FactoryGirl.create(:user, username: "Stepan", email: "stepan@example.com") }
    context "login admin" do
      login_admin
      before (:example) do
        get :show, id: user.id
      end
      it "has a 200 status code" do
        expect(response.status).to eq(200)
      end
      it "renders 'show' template" do
        expect(response).to render_template('show')
      end 
      it "assign @thrs not to be nil" do
        expect(assigns['user']).not_to be_nil
      end
    end 
    context "login user" do
      login_user
      before (:example) do
        get :show, id: user.id
      end
      it "has a 404 status code" do
        expect(response.status).to eq(404)
      end
    end 
    context "login banned user" do
      login_banned
      before (:example) do
        get :show, id: user.id
      end
      it "has a 404 status code" do
        expect(response.status).to eq(404)
      end
    end
  end

  describe "GET #show_thrs" do
    let (:user) { FactoryGirl.create(:user, username: "Stepan", email: "stepan@example.com") }
    let (:thr) { FactoryGirl.create(:thr) }
    let (:post) { FactoryGirl.create(:post) }
    context "login admin" do
      login_admin
      before (:example) do
        xhr :get, :show_thrs, id: user.id, format: "js"
      end
      it "has a 200 status code" do
        expect(response.status).to eq(200)
      end
      it "renders 'show_thrs' template" do
        expect(response).to render_template('show_thrs')
      end 
      it "assign @thrs not to be nil" do
        expect(assigns['thrs']).to eq(user.thrs)
      end
    end 
    context "login user" do
      login_user
      before (:example) do
        xhr :get, :show_thrs, id: user.id, format: "js"
      end
      it "has a 404 status code" do
        expect(response.status).to eq(404)
      end
    end 
    context "login banned user" do
      login_banned
      before (:example) do
        xhr :get, :show_thrs, id: user.id, format: "js"
      end
      it "has a 404 status code" do
        expect(response.status).to eq(404)
      end
    end
  end

  describe "GET #show_posts" do
    let (:user) { FactoryGirl.create(:user, username: "Stepan", email: "stepan@example.com") }
    let (:thr) { FactoryGirl.create(:thr) }
    let (:post) { FactoryGirl.create(:post) }
    context "login admin" do
      login_admin
      before (:example) do
        xhr :get, :show_posts, id: user.id, format: "js"
      end
      it "has a 200 status code" do
        expect(response.status).to eq(200)
      end
      it "renders 'show_posts' template" do
        expect(response).to render_template('show_posts')
      end 
      it "assign @posts not to be nil" do
        expect(assigns['posts']).to eq(user.posts)
      end
    end 
    context "login user" do
      login_user
      before (:example) do
        xhr :get, :show_posts, id: user.id, format: "js"
      end
      it "has a 404 status code" do
        expect(response.status).to eq(404)
      end
    end 
    context "login banned user" do
      login_banned
      before (:example) do
        xhr :get, :show_posts, id: user.id, format: "js"
      end
      it "has a 404 status code" do
        expect(response.status).to eq(404)
      end
    end
  end

  describe "GET #edit" do
    
    context "login admin" do
      login_admin
      let (:user) { FactoryGirl.create(:user, username: "Stepan", email: "stepan@example.com") }
      before (:example) do
        get :edit, id: user.id
      end
      it "has a 200 status code" do
        expect(response.status).to eq(200)
      end
      it "renders 'edit' template" do
        expect(response).to render_template('edit')
      end 
    end 
    context "login user" do
      login_user
      let (:user) { FactoryGirl.create(:user, username: "Stepan", email: "stepan@example.com") }
      before (:example) do
        get :edit, id: user.id
      end
      it "has a 404 status code" do
        expect(response.status).to eq(404)
      end
    end 
    context "login banned user" do
      login_banned
      let (:user) { FactoryGirl.create(:user, username: "Stepan", email: "stepan@example.com") }
      before (:example) do
        get :show_posts, id: user.id
      end
      it "has a 404 status code" do
        expect(response.status).to eq(404)
      end
    end
  end

  describe 'PUT #update' do 
    let (:user) { FactoryGirl.create(:user, username: "Stepan", email: "stepan@example.com") }
    let (:invalid_user) { FactoryGirl.attributes_for(:user, status: :banned, username: nil) }
    context "login admin" do
      login_admin
      context "valid attributes" do 
        it "located the requested @user" do 
          put :update, id: user.id, user: FactoryGirl.attributes_for(:user) 
          expect(assigns(:user)).to eq(user)
        end 
        it "changes @user attributes" do 
          put :update, id: user.id, user: FactoryGirl.attributes_for(:user, username: "Mykola")
          user.reload 
          expect(user.username).to eq('Mykola')
        end 
        it "redirects to users" do 
          put :update, id: user.id, user: FactoryGirl.attributes_for(:user, username: "Mykola")
          expect(flash[:notice]).to match(/^User successfully updated/)
          expect(response).to redirect_to("/users")
        end 
      end 
      context "invalid attributes" do 
        it "locates the requested @user" do 
         put :update, id: user.id, user: invalid_user
          expect(assigns(:user)).to eq(user) 
        end 
        it "does not change @user attributes" do 
          put :update, id: user.id, user: invalid_user
          user.reload 
          expect(user.username).to eq("Stepan")
          expect(user.status).not_to eq("banned")
        end 
        it "re-renders the edit action with errors" do
          put :update, id: user.id, user: invalid_user
          expect(response).to render_template(:edit)
          expect(assigns(:user).errors.any?).to be_truthy
        end 
      end 
    end 
    context "login user" do
      login_user
      it "has a 404 status code" do 
        put :update, id: user.id, user: user
        expect(response.status).to eq(404)
      end 
    end 
    context "login banned user" do
      login_banned
      it "has a 404 status code" do 
        put :update, id: user.id, user: user
        expect(response.status).to eq(404)
      end 
    end
  end 

end
