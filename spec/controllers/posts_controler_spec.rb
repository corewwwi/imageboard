require "rails_helper"

RSpec.describe PostsController, :type => :controller do

  describe "GET #new" do
    let (:thr) { create(:thr) } 

    shared_examples "allows access" do
      before (:example) do
        get :new, thr_id: thr.id, board_name: thr.board.name
      end 
      it "has a 200 status code" do
        expect(response.status).to eq(200)
      end
      it "renders 'new' template" do
        expect(response).to render_template('new')
      end 
      it "assign @post not no be nil" do
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
      before (:example) do
        get :new, thr_id: thr.id, board_name: thr.board.name
      end 
      it "has a 404 status code" do
        expect(response.status).to eq(404)
      end 
    end
  end  

  describe "POST #create" do 

    shared_examples "allows access" do
      let (:thr) { create(:thr) }
      let (:valid_post) { attributes_for(:post) }
      let (:invalid_post) { attributes_for(:post, content: nil) }

      context "with valid attributes" do 
        it "creates a new post" do 
          expect{ post :create, post: valid_post, thr_id: thr.id, board_name: thr.board.name }.to change(Post,:count).by(1) 
        end 

        context "JS format" do
          it "renders 'show' template" do 
            post :create, post: valid_post, thr_id: thr.id, board_name: thr.board.name, format: "js"
            expect(response).to render_template('show')
          end 
        end

        context "HTML format" do
          it "redirects to the post's thr" do 
            post :create, post: valid_post, thr_id: thr.id, board_name: thr.board.name
            expect(response).to redirect_to("/#{thr.board.name}/thrs/#{thr.id}")
          end
        end 
      end 

      context "with invalid attributes" do 
        it "does not save the new post" do 
          expect{ post :create, post: invalid_post, thr_id: thr.id, board_name: thr.board.name }.to_not change(Post,:count) 
        end 

        context "JS format" do
          it "renders 'show_error' template" do 
            post :create, post: invalid_post, thr_id: thr.id, board_name: thr.board.name, format: "js"
            expect(response).to render_template(:show_error)
            expect(assigns(:post).errors.any?).to be_truthy
          end
        end 

        context "HTML format" do
          it "re-renders the #new action with errors" do 
            post :create, post: invalid_post, thr_id: thr.id, board_name: thr.board.name
            expect(response).to render_template(:new)
            expect(assigns(:post).errors.any?).to be_truthy
          end
        end  
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
      let (:thr) { create(:thr) }
      let (:valid_post) { attributes_for(:post) }
      it "has a 404 status code" do 
        post :create, post: valid_post, thr_id: thr.id, board_name: thr.board.name
        expect(response.status).to eq(404)
      end 
      it "not creates a new board" do 
        expect{ post :create, post: valid_post, thr_id: thr.id, board_name: thr.board.name }.not_to change(Post,:count)
      end
    end
  end

end 