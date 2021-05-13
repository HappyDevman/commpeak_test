 require 'rails_helper'

 RSpec.describe '/tickets', type: :request do
   before do
     sign_in(current_user)
   end

   let(:current_user) { create(:user, :with_manager_role) }

   let(:valid_attributes) do
     {
       name: Faker::Lorem.characters(number: 8),
       email: Faker::Internet.email,
       subject: Faker::Lorem.characters(number: 10),
       content: Faker::Lorem.characters
     }
   end

   let(:invalid_attributes) do
     {
       name: '',
       email: ''
     }
   end

   let(:ticket) { create(:ticket) }

   describe 'GET /index' do
     it 'renders a successful response' do
       get tickets_url
       expect(response).to be_successful
     end
   end

   describe 'GET /show' do
     it 'renders a successful response' do
       get ticket_url(ticket)
       expect(response).to be_successful
     end
   end

   describe 'GET /new' do
     it 'renders a successful response' do
       get new_ticket_url
       expect(response).to be_successful
     end
   end

   describe 'GET /edit' do
     it 'render a successful response' do
       get edit_ticket_url(ticket)
       expect(response).to be_successful
     end
   end

   describe 'POST /submit' do
     before do
       allow(CsvExporter).to receive(:call).and_return(true)
     end

     context 'with valid parameters' do
       it 'submits a new Ticket' do
         post submit_tickets_url, params: { ticket: valid_attributes }
         expect(CsvExporter).to have_received(:call)
       end

       it 'redirects to the Tickets path' do
         post submit_tickets_url, params: { ticket: valid_attributes }
         expect(response).to redirect_to(tickets_url)
       end
     end

     context 'with invalid parameters' do
       it "renders a successful response (i.e. to display the 'new' template)" do
         post submit_tickets_url, params: { ticket: invalid_attributes }
         expect(response).to be_successful
       end
     end
   end

   describe 'PATCH /update' do
     context 'with valid parameters' do
       let(:new_attributes) do
         {
           name: 'updated_name'
         }
       end

       it 'updates the requested ticket' do
         patch ticket_url(ticket), params: { ticket: new_attributes }
         expect(ticket.reload.name).to eq(new_attributes[:name])
       end

       it 'redirects to the ticket' do
         patch ticket_url(ticket), params: { ticket: new_attributes }
         expect(response).to redirect_to(ticket_url(ticket))
       end
     end

     context 'with invalid parameters' do
       it "renders a successful response (i.e. to display the 'edit' template)" do
         patch ticket_url(ticket), params: { ticket: invalid_attributes }
         expect(response).to be_successful
       end
     end
   end

   describe 'DELETE /destroy' do
     it 'destroys the requested ticket' do
       ticket = current_user.tickets.create!(valid_attributes)
       expect do
         delete ticket_url(ticket)
       end.to change(Ticket, :count).by(-1)
     end

     it 'redirects to the tickets list' do
       delete ticket_url(ticket)
       expect(response).to redirect_to(tickets_url)
     end
   end
 end
