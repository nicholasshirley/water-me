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
    context 'when the user is signed in' do
      before(:each) { sign_in user }

      context 'and owns the record' do
        let(:log_entry) { FactoryBot.create(:log_entry, user_id: user.id) }

        it 'returns the page' do
          get log_entry_path(log_entry)

          expect(response).to have_http_status(200)
        end
      end

      context 'but does not own the record' do
        let(:log_entry) { FactoryBot.create(:log_entry) }

        it 'redirects with an error message' do
          get log_entry_path(log_entry)

          expect(flash[:danger]).not_to be_empty
          expect(response).to redirect_to log_entries_path
        end
      end
    end

    context 'when the user is not sigend in' do
      before(:each) { sign_out user }
      let(:log_entry) { FactoryBot.create(:log_entry) }

      it 'redirects to sign in' do
        get log_entry_path(log_entry)

        expect(response).to redirect_to new_user_session_path
      end
    end
  end

  describe 'GET an edit form for a single log entry' do
    context 'when the user is logged in' do
      before(:each) { sign_in user }

      context 'and owns the record' do
        let(:log_entry) { FactoryBot.create(:log_entry, user_id: user.id) }

        it 'returns the page' do
          get edit_log_entry_path(log_entry)

          expect(response).to have_http_status(200)
        end
      end

      context 'but does not own the record' do
        let(:log_entry) { FactoryBot.create(:log_entry) }

        it 'redirects with an error message' do
          get edit_log_entry_path(log_entry)

          expect(flash[:danger]).not_to be_empty
          expect(response).to redirect_to log_entries_path
        end
      end
    end

    context 'when the user is not logged in' do
      before(:each) { sign_out user }
      let(:log_entry) { FactoryBot.create(:log_entry) }

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

      context 'and the entry is well formed' do
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

      context 'but the entry is not well formed:' do
        context 'the date is missing' do
          missing_date_params = { log_entry: { volume: 10 } }

          it 'does not save the entry' do
            expect {
              post log_entries_path, params: missing_date_params
            }.not_to change { LogEntry.count }
          end
        end

        context 'the volume is missing' do
          missing_volume_params = { log_entry: { date: Date.today } }

          it 'does not save the entry' do
            expect {
              post log_entries_path, params: missing_volume_params
            }.not_to change { LogEntry.count }
          end
        end
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
    valid_patch_params = { log_entry: { date: Date.tomorrow, volume: 20 } }

    context 'when the user is signed in' do
      before(:each) { sign_in user }

      context 'and the update is well formed' do
        context 'and the user owns the record' do
          before(:each) { FactoryBot.create(:log_entry, user_id: user.id) }

          it 'updates the entry' do
            patch log_entry_path(LogEntry.last), params: valid_patch_params

            expect(LogEntry.last).to have_attributes(
              date: Date.tomorrow,
              volume: 20
            )
          end

          it 'redirects with a success message' do
            patch log_entry_path(LogEntry.last), params: valid_patch_params

            expect(flash[:success]).not_to be_empty
            expect(response).to redirect_to log_entry_path(LogEntry.last)
          end
        end

        context 'but the user does not own the record' do
          before(:each) { FactoryBot.create(:log_entry) }

          it 'does not updates the entry' do
            patch log_entry_path(LogEntry.last), params: valid_patch_params

            expect(LogEntry.last).not_to have_attributes(
              date: Date.tomorrow,
              volume: 20
            )
          end

          it 'redirects with an error message' do
            patch log_entry_path(LogEntry.last), params: valid_patch_params

            expect(flash[:danger]).not_to be_empty
            expect(response).to redirect_to log_entries_path
          end
        end
      end

      context 'but the update is not well formed:' do
        before(:each) { FactoryBot.create(:log_entry, user_id: user.id) }

        context 'the date is removed' do
          empty_date_params = { log_entry: { date: '', volume: 20 } }

          it 'does not update the entry' do
            patch log_entry_path(LogEntry.last), params: empty_date_params

            expect(LogEntry.last).not_to have_attributes(
              date: '',
              volume: 20
            )
          end
        end

        context 'the volume is removed' do
          empty_volume_params = { log_entry: { date: Date.tomorrow, volume: '' } }

          it 'does not update the entry' do
            patch log_entry_path(LogEntry.last), params: empty_volume_params

            expect(LogEntry.last).not_to have_attributes(
              date: Date.tomorrow,
              volume: ''
            )
          end
        end
      end
    end

    context 'when the user is not siged in' do
      before(:each) { sign_out user }
      before(:each) { FactoryBot.create(:log_entry) }

      it 'does not update the entry' do
        patch log_entry_path(LogEntry.last), params: valid_patch_params

        expect(LogEntry.last).not_to have_attributes(
          date: Date.tomorrow,
          volume: 20
        )
      end

      it 'redirects to sign in' do
        patch log_entry_path(LogEntry.last), params: valid_patch_params

        expect(response).to redirect_to new_user_session_path
      end
    end
  end

  describe 'DELETE an existing log entry' do
    context 'when the user is logged in' do
      before(:each) { sign_in user }

      context 'and owns the record' do
        before(:each) { FactoryBot.create(:log_entry, user_id: user.id) }

        it 'remove the record' do
          expect {
            delete log_entry_path(LogEntry.last)
          }.to change{ LogEntry.count }.by(-1)
        end

        it 'redirects with a success message' do
          delete log_entry_path(LogEntry.last)

          expect(flash[:success]).not_to be_empty
        end
      end

      context 'but does not own the record' do
        before(:each) { FactoryBot.create(:log_entry) }

        it 'does not remove the record' do
          expect {
            delete log_entry_path(LogEntry.last)
          }.not_to change{ LogEntry.count }
        end

        it 'redirects with an error' do
          delete log_entry_path(LogEntry.last)

          expect(flash[:danger]).not_to be_empty
          expect(response).to redirect_to log_entries_path
        end
      end
    end

    context 'when the user is not logged in' do
      before(:each) { sign_out user }
      before(:each) { FactoryBot.create(:log_entry) }

      it 'does not remove the record' do
        expect {
          delete log_entry_path(LogEntry.last)
        }.not_to change{ LogEntry.count }
      end

      it 'redirects to sign in' do
        delete log_entry_path(LogEntry.last)

        expect(response).to redirect_to new_user_session_path
      end
    end
  end
end
