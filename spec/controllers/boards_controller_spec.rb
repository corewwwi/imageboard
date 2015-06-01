require "rails_helper"

RSpec.describe BoardsController, :type => :controller do

  describe "GET #index" do
    context "login admin" do
      login_admin
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
    let (:board) { FactoryGirl.create(:board) }
    before (:example) do
      get :show, name: board.name
    end
    context "login admin" do
      login_admin
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
    context "login user" do
      login_user
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
    context "login banned user" do
      login_banned
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
  end

  describe "GET #new" do
    context "login admin" do
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
    context "login user" do
      login_user
      before (:example) do
        get :new
      end  
      it "has a 404 status code" do
        expect(response.status).to eq(404)
      end 
    end 
    context "login banned user" do
      login_banned
      before (:example) do
        get :new
      end  
      it "has a 404 status code" do
        expect(response.status).to eq(404)
      end 
    end
  end  

  describe "POST #create" do 
    context "login admin" do
      login_admin
      context "with valid attributes" do 
        let (:board) { FactoryGirl.attributes_for(:board) }
        it "creates a new board" do 
          expect{ post :create, board: board }.to change(Board,:count).by(1) 
        end 
        it "redirects to #index" do 
          post :create, board: board 
          expect(flash[:notice]).to match(/^Board successfully created/)
          expect(response).to redirect_to(action: :index)
        end 
      end 
      context "with invalid attributes" do 
        let (:board) { FactoryGirl.attributes_for(:board, name: nil) }
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
    context "login user" do 
      login_user
      let (:board) { FactoryGirl.attributes_for(:board) }
      it "has a 404 status code" do 
        post :create, board: board 
        expect(response.status).to eq(404)
      end 
      it "not creates a new board" do 
        expect{ post :create, board: board }.not_to change(Board,:count)
      end
    end 
    context "login banned" do 
      login_banned
      let (:board) { FactoryGirl.attributes_for(:board) }
      it "has a 404 status code" do 
        post :create, board: board 
        expect(response.status).to eq(404)
      end 
      it "not creates a new board" do 
        expect{ post :create, board: board }.not_to change(Board,:count)
      end
    end
  end

  describe "GET #edit" do
    
    context "login admin" do
      login_admin
      let (:board) { FactoryGirl.create(:board) }
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
    context "login user" do
      login_user
      let (:board) { FactoryGirl.create(:board) }
      before (:example) do
        get :edit, name: board.name
      end
      it "has a 404 status code" do
        expect(response.status).to eq(404)
      end
    end 
    context "login banned user" do
      login_banned
      let (:board) { FactoryGirl.create(:board) }
      before (:example) do
        get :edit, name: board.name
      end
      it "has a 404 status code" do
        expect(response.status).to eq(404)
      end
    end
  end

  describe 'PUT #update' do 
    let (:board) { FactoryGirl.create(:board) }
    let (:invalid_board) { FactoryGirl.attributes_for(:board, name: nil, description: "Movies")  }
    context "login admin" do
      login_admin
      context "valid attributes" do 
        it "located the requested @board" do 
          put :update, name: board.name, board: FactoryGirl.attributes_for(:board) 
          expect(assigns(:board)).to eq(board)
        end 
        it "changes @board's attributes" do 
          put :update, name: board.name, board: FactoryGirl.attributes_for(:board, name: "mov", description: "Movies") 
          board.reload 
          expect(board.name).to eq("mov")
          expect(board.description).to eq("Movies")
        end 
        it "redirects to index" do 
          put :update, name: board.name, board: FactoryGirl.attributes_for(:board)
          expect(response).to redirect_to(action: :index)
        end 
      end 
      context "invalid attributes" do 
        it "locates the requested @board" do 
          put :update, name: board.name, board: invalid_board
          expect(assigns(:board)).to eq(board) 
        end 
        it "does not change @board's attributes" do 
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
    context "login user" do
      login_user
      it "has a 404 status code" do 
        put :update, name: board.name, board: invalid_board 
        expect(response.status).to eq(404)
      end 
    end 
    context "login banned user" do
      login_banned
      it "has a 404 status code" do 
        put :update, name: board.name, board: invalid_board  
        expect(response.status).to eq(404)
      end 
    end
  end 

  describe 'DELETE #destroy' do 
    let! (:board) { FactoryGirl.create(:board) }
    context "login admin" do
      login_admin
      it "deletes board" do
        expect{ delete :destroy, name: board.name }.to change(Board,:count).by(-1)
      end
      it "redirects to #index" do
        delete :destroy, name: board.name 
        expect(flash[:notice]).to match(/^Board successfully destroyed/)
        expect(response).to redirect_to(action: :index)
      end  
      
    end 
    context "login user" do
      login_user
      it "has a 404 status code" do 
        delete :destroy, name: board.name
        expect(response.status).to eq(404)
      end 
    end 
    context "login banned user" do
      login_banned
      it "has a 404 status code" do 
        delete :destroy, name: board.name
        expect(response.status).to eq(404)
      end
    end
  end 

end