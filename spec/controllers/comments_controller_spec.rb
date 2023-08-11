require 'rails_helper'

RSpec.describe CommentsController, type: :controller do
  let(:user) { FactoryBot.create(:user) }
  let(:wish) { FactoryBot.create(:wish) }
  let(:comment) { FactoryBot.create(:comment, user:, wish:) }

  before do
    sign_in user
  end

  describe 'POST #create' do
    context 'with valid params' do
      let(:comment_params) { FactoryBot.attributes_for(:comment, content: 'Test Comment') }

      it 'creates a new comment' do
        expect do
          post :create, params: { wish_id: wish.id, comment: comment_params }
        end.to change(Comment, :count).by(1)
      end

      it 'assigns the newly created comment' do
        post :create, params: { wish_id: wish.id, comment: comment_params }
        expect(assigns(:comment)).to be_a(Comment)
      end

      it 'redirects to the wish show page' do
        post :create, params: { wish_id: wish.id, comment: comment_params }
        expect(response).to redirect_to(wish_path(wish))
      end
    end

    context 'with invalid params' do
      let(:invalid_comment_params) { FactoryBot.attributes_for(:comment, content: nil) }

      it 'does not create a new comment' do
        expect do
          post :create, params: { wish_id: wish.id, comment: invalid_comment_params }
        end.not_to change(Comment, :count)
      end

      it 're-renders the wishes/show template' do
        post :create, params: { wish_id: wish.id, comment: invalid_comment_params }
        expect(response).to render_template('wishes/show')
      end
    end
  end

  describe 'PATCH #update' do
    context 'with valid params' do
      let(:valid_comment_params) { FactoryBot.attributes_for(:comment, content: 'Updated Comment') }

      it 'updates the comment' do
        patch :update, params: { wish_id: wish.id, id: comment.id, comment: valid_comment_params }
        comment.reload
        expect(comment.content).to eq('Updated Comment')
      end

      it 'redirects to the wish show page' do
        patch :update, params: { wish_id: wish.id, id: comment.id, comment: valid_comment_params }
        expect(response).to redirect_to(wish_path(wish))
      end
    end
  end

  describe 'DELETE #destroy' do
    it 'destroys the comment' do
      comment
      expect {
        delete :destroy, params: { wish_id: wish.id, id: comment.id }
      }.to change(Comment, :count).by(-1)
    end

    it 'redirects to the wish show page' do
      delete :destroy, params: { wish_id: wish.id, id: comment.id }
      expect(response).to redirect_to(wish_path(wish))
    end
  end
end
