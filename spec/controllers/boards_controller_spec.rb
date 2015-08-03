require "rails_helper"

RSpec.describe BoardsController, :type => :controller do

  describe "GET #index" do

    shared_examples "allows access" do
      before (:example) do
        get :index 
      end   
      let (:boards) { Board.all.order(name: :desc) }

      it "has a 200 status code" do
        expect(response.status).to eq(200)
      end
      it "renders 'index' template" do
        expect(response).to render_template('index')
      end 
      it "assign all boards to @boards" do
        expect(assigns['boards']).to eq(boards)
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
    let (:board) { create(:board) }

    shared_examples "allows access" do
      before (:example) do
        get :show, name: board.name
      end
      it "has a 200 status code" do
        expect(response.status).to eq(200)
      end
      it "renders 'show' template" do
        expect(response).to render_template('show')
      end 
      it "assign @thrs not to be nil" do
        expect(assigns['thrs']).not_to be_nil
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

    shared_examples "deny access" do
      before (:example) do
        get :new
      end  
      it "has a 500 status code" do
        expect(response.status).to eq(500)
      end 
    end

    context "when login admin" do
      login_admin
      before (:example) do
        get :new
      end  
      it "has a 200 status code" do
        expect(response.status).to eq(200)
      end
      it "renders 'new' template" do
        expect(response).to render_template('new')
      end 
      it "assign @board not no be nil" do
        expect(assigns['board']).not_to be_nil
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

  describe "POST #create" do 

    shared_examples "deny access" do
      let (:board) { attributes_for(:board) }
      it "has a 500 status code" do 
        post :create, board: board 
        expect(response.status).to eq(500)
      end 
      it "not creates a new board" do 
        expect{ post :create, board: board }.not_to change(Board,:count)
      end 
    end

    context "when login admin" do
      login_admin

      context "with valid attributes" do 
        let (:board) { attributes_for(:board) }
        it "creates a new board" do 
          expect{ post :create, board: board }.to change(Board,:count).by(1) 
        end 
        it "redirects to #index" do 
          post :create, board: board 
          expect(response).to redirect_to(action: :index)
        end 
        it "appears success flash" do
          post :create, board: board 
          expect(flash[:notice]).to match(/^Board successfully created/)
        end  
      end 

      context "with invalid attributes" do 
        let (:board) { attributes_for(:board, name: nil) }
        it "does not save the new board" do 
          expect{ post :create, board: board }.to_not change(Board,:count) 
        end 
        it "re-renders the #new action with errors" do 
          post :create, board: board 
          expect(response).to render_template(:new)
          expect(assigns(:board).errors.any?).to be_truthy
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

  describe "GET #edit" do

    shared_examples "deny access" do
      let (:board) { create(:board) }
      before (:example) do
        get :edit, name: board.name
      end
      it "has a 500 status code" do
        expect(response.status).to eq(500)
      end 
    end
    
    context "when login admin" do
      login_admin
      let (:board) { create(:board) }
      before (:example) do
        get :edit, name: board.name
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
    let (:board) { create(:board) }
    let (:invalid_board) { attributes_for(:board, name: nil, description: "Movies")  }
    
    shared_examples "deny access" do
      it "has a 500 status code" do 
        put :update, name: board.name, board: invalid_board 
        expect(response.status).to eq(500)
      end 
    end

    context "when login admin" do
      login_admin

      context "valid attributes" do 
        it "located the requested @board" do 
          put :update, name: board.name, board: attributes_for(:board) 
          expect(assigns(:board)).to eq(board)
        end 
        it "changes @board attributes" do 
          put :update, name: board.name, board: attributes_for(:board, name: "mov", description: "Movies") 
          board.reload 
          expect(board.name).to eq("mov")
          expect(board.description).to eq("Movies")
        end 
        it "redirects to index" do 
          put :update, name: board.name, board: attributes_for(:board)
          expect(response).to redirect_to(action: :index)
        end 
      end 

      context "invalid attributes" do 
        it "locates the requested @board" do 
          put :update, name: board.name, board: invalid_board
          expect(assigns(:board)).to eq(board) 
        end 
        it "does not change @board attributes" do 
          put :update, name: board.name, board: invalid_board
          board.reload 
          expect(board.name).to eq("pr")
          expect(board.description).not_to eq("Movies") 
        end 
        it "re-renders the edit action with errors" do
          put :update, name: board.name, board: invalid_board
          expect(response).to render_template(:edit)
          expect(assigns(:board).errors.any?).to be_truthy
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
    let! (:board) { create(:board) }

    shared_examples "deny access" do
      it "has a 500 status code" do 
        delete :destroy, name: board.name
        expect(response.status).to eq(500)
      end 
    end

    context "when login admin" do
      login_admin
      it "deletes board" do
        expect{ delete :destroy, name: board.name }.to change(Board,:count).by(-1)
      end
      it "redirects to #index" do
        delete :destroy, name: board.name 
        expect(response).to redirect_to(action: :index)
      end  
      it "appears success flash" do
        delete :destroy, name: board.name 
        expect(flash[:notice]).to match(/^Board successfully destroyed/)
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