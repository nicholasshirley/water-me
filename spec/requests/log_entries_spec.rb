require 'rails_helper'

RSpec.describe 'Log entries', type: :request do
  let(:user) { FactoryBot.create(:user) }

  describe 'GET the index of all log entries' do
    context 'when the user is logged in' do
      before(:each) { sign_in user }

      it 'returns the index' do
        get log_entries_path

        expect(response).to have_http_status(200)
      end
    end

    context 'when the user is not logged in' do
      before(:each) { sign_out user }

      it 'redirects to sign in' do
        get log_entries_path

        expect(response).to redirect_to new_user_session_path
      end
    end
  end

  describe 'GET the show page for a single log entry' do

  end

  describe 'GET an edit form for a single log entry' do

  end

  describe 'POST a new log entry' do

  end

  describe 'PATCH/PUT an existing log entry' do

  end

  describe 'DELETE an existing log entry' do

  end
end
