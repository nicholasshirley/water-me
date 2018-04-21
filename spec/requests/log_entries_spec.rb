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

  describe 'GET the new page for a log entry' do
    context 'when the user is signed in' do
      before(:each) { sign_in user }

      it 'returns the page' do
        get new_log_entry_path

        expect(response).to have_http_status(200)
      end
    end

    context 'when the user is not sigend in' do
      before(:each) { sign_out user }

      it 'redirects to sign in' do
        get new_log_entry_path

        expect(response).to redirect_to new_user_session_path
      end
    end
  end

  describe 'GET the show page for a single log entry' do
    let(:log_entry) { FactoryBot.create(:log_entry) }

    context 'when the user is signed in' do
      before(:each) { sign_in user }

      it 'returns the page' do
        get log_entry_path(log_entry)

        expect(response).to have_http_status(200)
      end
    end

    context 'when the user is not sigend in' do
      before(:each) { sign_out user }

      it 'redirects to sign in' do
        get log_entry_path(log_entry)

        expect(response).to redirect_to new_user_session_path
      end
    end
  end

  describe 'GET an edit form for a single log entry' do
    let(:log_entry) { FactoryBot.create(:log_entry) }

    context 'when the user is logged in' do
      before(:each) { sign_in user }

      it 'returns the page' do
        get edit_log_entry_path(log_entry)

        expect(response).to have_http_status(200)
      end
    end

    context 'when the user is not logged in' do
      before(:each) { sign_out user }

      it 'redirects to sign in' do
        get edit_log_entry_path(log_entry)

        expect(response).to redirect_to new_user_session_path
      end
    end
  end

  describe 'POST a new log entry' do
    valid_params = { log_entry: { date: Date.today, volume: 10 } }

    context 'when the user is signed in' do
      before(:each) { sign_in user }

      it 'saves the entry' do
        expect {
          post log_entries_path, params: valid_params
        }.to change { LogEntry.count }.by(1)
      end

      it 'redirects with a success message' do
        post log_entries_path, params: valid_params

        expect(flash[:success]).not_to be_empty
        expect(response).to redirect_to log_entry_path(LogEntry.last)
      end
    end

    context 'when the user is not signed in' do
      before(:each) { sign_out user }

      it 'does not save the entry' do
        expect {
          post log_entries_path, params: valid_params
        }.not_to change { LogEntry.count }
      end

      it 'redirects to sign in' do
        post log_entries_path, params: valid_params

        expect(response).to redirect_to new_user_session_path
      end
    end
  end

  describe 'PATCH/PUT an existing log entry' do

  end

  describe 'DELETE an existing log entry' do

  end
end
