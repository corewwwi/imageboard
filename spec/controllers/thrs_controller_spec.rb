require "rails_helper"

RSpec.describe ThrsController, :type => :controller do

  describe "GET #most" do
    let (:thrs) { Thr.all.order(updated_at: :desc).limit(10) }

    shared_examples "allows access" do
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

  describe "GET #show" do
    let (:thr) { create(:thr) }
    let (:posts) { thr.posts.order(:created_at) }
    before (:example) do
      get :show, id: thr.id, board_name: thr.board.name
    end

    shared_examples "allows access" do
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

  describe "GET #new" do
    let (:thr) { create(:thr) } 

    shared_examples "allows access" do
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

    context "when login admin" do
      login_admin
      before (:example) do
        get :new, board_name: thr.board.name
      end 
      it_behaves_like "allows access"  
    end 

    context "when login user" do
      login_user
      before (:example) do
        get :new, board_name: thr.board.name
      end 
      it_behaves_like "allows access" 
    end 

    context "when login banned user" do
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

    shared_examples "allows creating post" do
      let (:board) { create(:board) }
      let (:thr) { attributes_for(:thr) }
      let (:invalid_thr) { attributes_for(:thr, title: nil) }

      context "with valid attributes" do 
        it "creates a new thr" do 
          expect{ post :create, thr: thr, board_name: board.name }.to change(Thr,:count).by(1) 
        end 
        it "redirects to the new thr" do 
          post :create, thr: thr, board_name: board.name
          expect(response).to redirect_to("/#{board.name}/thrs/#{assigns(:thr).id}")
        end 
        it "appears success flash" do
          post :create, thr: thr, board_name: board.name
          expect(flash[:notice]).to match(/^Thread successfully created/)
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

    context "when login admin" do
      login_admin
      it_behaves_like "allows creating post"
    end

    context "when login user" do 
      login_user
      it_behaves_like "allows creating post"
    end  

    context "when login banned user" do 
      login_banned
      let (:board) { create(:board) }
      let (:thr) { attributes_for(:thr) }
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

    shared_examples "deny access" do
      let (:thr) { create(:thr) }
      before (:example) do
        get :edit, id: thr.id, board_name: thr.board.name
      end
      it "has a 404 status code" do
        expect(response.status).to eq(404)
      end
    end
    
    context "when login admin" do
      login_admin
      let (:thr) { create(:thr) }
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

    context "when login user" do
      login_user
      it_behaves_like "deny access"
    end 

    context "when login banned user" do
      login_banned
      it_behaves_like "deny access"
    end
  end

  describe 'PUT #update' do 
    let (:thr) { create(:thr) }
    let (:invalid_thr) { attributes_for(:thr, title: nil) }

    shared_examples "deny access" do
      it "has a 404 status code" do 
        put :update, id: thr.id, board_name: thr.board.name, thr: attributes_for(:thr, title: 'New Thread') 
        expect(response.status).to eq(404)
      end
    end

    context "when login admin" do
      login_admin

      context "valid attributes" do 
        it "located the requested @thr" do 
          put :update, id: thr.id, board_name: thr.board.name, thr: attributes_for(:thr) 
          expect(assigns(:thr)).to eq(thr)
        end 
        it "changes @thr attributes" do 
          put :update, id: thr.id, board_name: thr.board.name, thr: attributes_for(:thr, title: 'New Thread') 
          thr.reload 
          expect(thr.title).to eq('New Thread')
        end 
        it "redirects to updated thr" do 
          put :update, id: thr.id, board_name: thr.board.name, thr: attributes_for(:thr, title: 'New Thread')
          expect(response).to redirect_to("/#{thr.board.name}/thrs/#{assigns(:thr).id}")
        end 
        it "appears success flash" do
          put :update, id: thr.id, board_name: thr.board.name, thr: attributes_for(:thr, title: 'New Thread')
          expect(flash[:notice]).to match(/^Thread successfully updated/)
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

    context "when login user" do
      login_user
      it_behaves_like "deny access" 
    end 

    context "when login banned user" do
      login_banned
      it_behaves_like "deny access"
    end
  end 

  describe 'DELETE #destroy' do 
    let! (:thr) { create(:thr) }

    shared_examples "deny access" do
      it "has a 404 status code" do 
        delete :destroy, id: thr.id, board_name: thr.board.name
        expect(response.status).to eq(404)
      end 
    end

    context "when login admin" do
      login_admin
      it "deletes thr" do
        expect{ delete :destroy, id: thr.id, board_name: thr.board.name }.to change(Thr,:count).by(-1)
      end
      it "redirects to thr.board" do
        delete :destroy, id: thr.id, board_name: thr.board.name
        expect(response).to redirect_to ("/#{thr.board.name}")
      end  
      it "appears success flash" do
        delete :destroy, id: thr.id, board_name: thr.board.name
        expect(flash[:notice]).to match(/^Thread successfully destroyed/)
      end
      
    end 

    context "when login user" do
      login_user
      it_behaves_like "deny access" 
    end 
    
    context "when login banned user" do
      login_banned
      it_behaves_like "deny access" 
    end
  end 

end