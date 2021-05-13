 require 'rails_helper'

 RSpec.describe '/comments', type: :request do
   before do
     sign_in(current_user)
   end

   let(:current_user) { create(:user, :with_manager_role) }

   let(:ticket) { create(:ticket) }

   let(:comment) { create(:comment) }

   let(:valid_attributes) do
     {
       text: Faker::Lorem.characters
     }
   end

   let(:invalid_attributes) do
     {
       text: ''
     }
   end

   describe 'GET /new' do
     it 'renders a successful response' do
       get new_ticket_comment_url(ticket)
       expect(response).to be_successful
     end
   end

   describe 'GET /edit' do
     it 'render a successful response' do
       get edit_ticket_comment_path(ticket, comment)
       expect(response).to be_successful
     end
   end

   describe 'POST /create' do
     context 'with valid parameters' do
       it 'creates a new Comment' do
         expect do
           post ticket_comments_url(ticket), params: { comment: valid_attributes }
         end.to change(Comment, :count).by(1)
       end

       it 'redirects to the ticket' do
         post ticket_comments_url(ticket), params: { comment: valid_attributes }
         expect(response).to redirect_to(ticket_url(ticket))
       end
     end

     context 'with invalid parameters' do
       it 'does not create a new Comment' do
         expect do
           post ticket_comments_url(ticket), params: { comment: invalid_attributes }
         end.to change(Comment, :count).by(0)
       end

       it "renders a successful response (i.e. to display the 'new' template)" do
         post ticket_comments_url(ticket), params: { comment: invalid_attributes }
         expect(response).to be_successful
       end
     end
   end

   describe 'PATCH /update' do
     context 'with valid parameters' do
       let(:new_attributes) do
         { text: 'updated text' }
       end

       it 'updates the requested comment' do
         patch ticket_comment_url(ticket, comment), params: { comment: new_attributes }
         expect(comment.reload.text).to eq(new_attributes[:text])
       end

       it 'redirects to the ticket' do
         patch ticket_comment_url(ticket, comment), params: { comment: new_attributes }
         expect(response).to redirect_to(ticket_url(ticket))
       end
     end

     context 'with invalid parameters' do
       it "renders a successful response (i.e. to display the 'edit' template)" do
         patch ticket_comment_url(ticket, comment), params: { comment: invalid_attributes }
         expect(response).to be_successful
       end
     end
   end

   describe 'DELETE /destroy' do
     it 'destroys the requested comment' do
       comment = ticket.comments.create! valid_attributes
       expect do
         delete ticket_comment_url(ticket, comment)
       end.to change(Comment, :count).by(-1)
     end

     it 'redirects to the ticket' do
       comment = ticket.comments.create! valid_attributes
       delete ticket_comment_url(ticket, comment)
       expect(response).to redirect_to(ticket_url(ticket))
     end
   end
 end
