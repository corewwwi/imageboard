require "rails_helper"

RSpec.describe ThrsController, :type => :controller do

  describe "GET #most" do
    let (:thrs) { Thr.all.order(updated_at: :desc).limit(10) }
    context "login admin" do
      login_admin
      before (:example) do
        get :most 
      end  
      it "has a 200 status code" do
        expect(response.status).to eq(200)
      end
      it "renders 'most' template" do
        expect(response).to render_template('most')
      end 
      it "assign all thrss to @thrs" do
        expect(assigns['thrs']).to eq(thrs)
      end 
    end 
    context "login user" do
      login_user
      before (:example) do
        get :most 
      end  
      it "has a 200 status code" do
        expect(response.status).to eq(200)
      end
      it "renders 'most' template" do
        expect(response).to render_template('most')
      end 
      it "assign all thrss to @thrs" do
        expect(assigns['thrs']).to eq(thrs)
      end 
    end 
    context "login banned user" do
      login_banned
     before (:example) do
        get :most 
      end  
      it "has a 200 status code" do
        expect(response.status).to eq(200)
      end
      it "renders 'most' template" do
        expect(response).to render_template('most')
      end 
      it "assign all thrss to @thrs" do
        expect(assigns['thrs']).to eq(thrs)
      end 
    end
  end

  describe "GET #show" do
    let (:thr) { FactoryGirl.create(:thr) }
    let (:posts) { thr.posts.order(:created_at) }
    before (:example) do
      get :show, id: thr.id, board_name: thr.board.name
    end
    context "login admin" do
      login_admin
      it "has a 200 status code" do
        expect(response.status).to eq(200)
      end
      it "renders 'show' template" do
        expect(response).to render_template('show')
      end 
      it "the requested posts to @posts" do
        expect(assigns['posts']).to eq(posts)
      end
      it "assign @post not to be nil" do
        expect(assigns['post']).not_to be_nil
      end
    end 
    context "login user" do
      login_user
      it "has a 200 status code" do
        expect(response.status).to eq(200)
      end
      it "renders 'show' template" do
        expect(response).to render_template('show')
      end 
      it "the requested posts to @posts" do
        expect(assigns['posts']).to eq(posts)
      end
      it "assign @post not to be nil" do
        expect(assigns['post']).not_to be_nil
      end
    end 
    context "login banned user" do
      login_banned
      it "has a 200 status code" do
        expect(response.status).to eq(200)
      end
      it "renders 'show' template" do
        expect(response).to render_template('show')
      end 
      it "the requested posts to @posts" do
        expect(assigns['posts']).to eq(posts)
      end
      it "assign @post not to be nil" do
        expect(assigns['post']).not_to be_nil
      end 
    end
  end

  describe "GET #new" do
    let (:thr) { FactoryGirl.create(:thr) } 
    context "login admin" do
      login_admin
      before (:example) do
        get :new, board_name: thr.board.name
      end 
      it "has a 200 status code" do
        expect(response.status).to eq(200)
      end
      it "renders 'new' template" do
        expect(response).to render_template('new')
      end 
      it "assign @thr not no be nil" do
        expect(assigns['thr']).not_to be_nil
      end  
    end 
    context "login user" do
      login_user
      before (:example) do
        get :new, board_name: thr.board.name
      end 
      it "has a 200 status code" do
        expect(response.status).to eq(200)
      end
      it "renders 'new' template" do
        expect(response).to render_template('new')
      end 
      it "assign @thr not no be nil" do
        expect(assigns['thr']).not_to be_nil
      end 
    end 
    context "login banned user" do
      login_banned
      before (:example) do
        get :new, board_name: thr.board.name
      end 
      it "has a 404 status code" do
        expect(response.status).to eq(404)
      end 
    end
  end  

  describe "POST #create" do 
    context "login admin" do
      login_admin
      let (:board) { FactoryGirl.create(:board) }
      let (:thr) { FactoryGirl.attributes_for(:thr) }
      let (:invalid_thr) { FactoryGirl.attributes_for(:thr, title: nil) }
      context "with valid attributes" do 
        it "creates a new thr" do 
          expect{ post :create, thr: thr, board_name: board.name }.to change(Thr,:count).by(1) 
        end 
        it "redirects to the new thr" do 
          post :create, thr: thr, board_name: board.name
          expect(flash[:notice]).to match(/^Thread successfully created/)
          expect(response).to redirect_to("/#{board.name}/thrs/#{assigns(:thr).id}")
        end 
      end 
      context "with invalid attributes" do 
        it "does not save the new thr" do 
          expect{ post :create, thr: invalid_thr, board_name: board.name }.to_not change(board.thrs,:count) 
        end 
        it "re-renders the #new action with errors" do 
          post :create, thr: invalid_thr, board_name: board.name
          expect(response).to render_template(:new)
          expect(assigns(:thr).errors.any?).to be_truthy
        end
      end 
    end
    context "login user" do 
      login_user
      let (:board) { FactoryGirl.create(:board) }
      let (:thr) { FactoryGirl.attributes_for(:thr) }
      let (:invalid_thr) { FactoryGirl.attributes_for(:thr, title: nil) }
      context "with valid attributes" do 
        it "creates a new thr" do 
          expect{ post :create, thr: thr, board_name: board.name }.to change(Thr,:count).by(1) 
        end 
        it "redirects to the new thr" do 
          post :create, thr: thr, board_name: board.name
          expect(flash[:notice]).to match(/^Thread successfully created/)
          expect(response).to redirect_to("/#{board.name}/thrs/#{assigns(:thr).id}")
        end 
      end 
      context "with invalid attributes" do 
        it "does not save the new board" do 
          expect{ post :create, thr: invalid_thr, board_name: board.name }.to_not change(board.thrs,:count) 
        end 
        it "re-renders the #new action with errors" do 
          post :create, thr: invalid_thr, board_name: board.name
          expect(response).to render_template(:new)
          expect(assigns(:thr).errors.any?).to be_truthy
        end
      end 
    end  
    context "login banned" do 
      login_banned
      let (:board) { FactoryGirl.create(:board) }
      let (:thr) { FactoryGirl.attributes_for(:thr) }
      it "has a 404 status code" do 
        post :create, thr: thr, board_name: board.name
        expect(response.status).to eq(404)
      end 
      it "not creates a new board" do 
        expect{ post :create, thr: thr, board_name: board.name }.not_to change(board.thrs,:count)
      end
    end
  end

  describe "GET #edit" do
    
    context "login admin" do
      login_admin
      let (:thr) { FactoryGirl.create(:thr) }
      before (:example) do
        get :edit, id: thr.id, board_name: thr.board.name
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
      let (:thr) { FactoryGirl.create(:thr) }
      before (:example) do
        get :edit, id: thr.id, board_name: thr.board.name
      end
      it "has a 404 status code" do
        expect(response.status).to eq(404)
      end
    end 
    context "login banned user" do
      login_banned
      let (:thr) { FactoryGirl.create(:thr) }
      before (:example) do
        get :edit, id: thr.id, board_name: thr.board.name
      end
      it "has a 404 status code" do
        expect(response.status).to eq(404)
      end
    end
  end

  describe 'PUT #update' do 
    let (:thr) { FactoryGirl.create(:thr) }
    let (:invalid_thr) { FactoryGirl.attributes_for(:thr, title: nil) }
    context "login admin" do
      login_admin
      context "valid attributes" do 
        it "located the requested @thr" do 
          put :update, id: thr.id, board_name: thr.board.name, thr: FactoryGirl.attributes_for(:thr) 
          expect(assigns(:thr)).to eq(thr)
        end 
        it "changes @thr attributes" do 
          put :update, id: thr.id, board_name: thr.board.name, thr: FactoryGirl.attributes_for(:thr, title: 'New Thread') 
          thr.reload 
          expect(thr.title).to eq('New Thread')
        end 
        it "redirects to updated thr" do 
          put :update, id: thr.id, board_name: thr.board.name, thr: FactoryGirl.attributes_for(:thr, title: 'New Thread')
          expect(flash[:notice]).to match(/^Thread successfully updated/)
          expect(response).to redirect_to("/#{thr.board.name}/thrs/#{assigns(:thr).id}")
        end 
      end 
      context "invalid attributes" do 
        it "locates the requested @thr" do 
          put :update, id: thr.id, board_name: thr.board.name, thr: invalid_thr
          expect(assigns(:thr)).to eq(thr) 
        end 
        it "does not change @thr attributes" do 
          put :update, id: thr.id, board_name: thr.board.name, thr: invalid_thr
          thr.reload 
          expect(thr.title).to eq("Thread")
        end 
        it "re-renders the edit action with errors" do
          put :update, id: thr.id, board_name: thr.board.name, thr: invalid_thr
          expect(response).to render_template(:edit)
          expect(assigns(:thr).errors.any?).to be_truthy
        end 
      end 
    end 
    context "login user" do
      login_user
      it "has a 404 status code" do 
        put :update, id: thr.id, board_name: thr.board.name, thr: FactoryGirl.attributes_for(:thr, title: 'New Thread') 
        expect(response.status).to eq(404)
      end 
    end 
    context "login banned user" do
      login_banned
      it "has a 404 status code" do 
        put :update, id: thr.id, board_name: thr.board.name, thr: FactoryGirl.attributes_for(:thr, title: 'New Thread') 
        expect(response.status).to eq(404)
      end 
    end
  end 

  describe 'DELETE #destroy' do 
    let! (:thr) { FactoryGirl.create(:thr) }
    context "login admin" do
      login_admin
      it "deletes thr" do
        expect{ delete :destroy, id: thr.id, board_name: thr.board.name }.to change(Thr,:count).by(-1)
      end
      it "redirects to thr.board" do
        delete :destroy, id: thr.id, board_name: thr.board.name
        expect(flash[:notice]).to match(/^Thread successfully destroyed/)
        expect(response).to redirect_to ("/#{thr.board.name}")
      end  
      
    end 
    context "login user" do
      login_user
      it "has a 404 status code" do 
        delete :destroy, id: thr.id, board_name: thr.board.name
        expect(response.status).to eq(404)
      end 
    end 
    context "login banned user" do
      login_banned
      it "has a 404 status code" do 
        delete :destroy, id: thr.id, board_name: thr.board.name
        expect(response.status).to eq(404)
      end
    end
  end 

end