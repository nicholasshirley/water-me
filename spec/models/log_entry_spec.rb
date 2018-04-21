require 'rails_helper'

RSpec.describe LogEntry, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:date) }

    it { should validate_uniqueness_of(:date).scoped_to(:user_id) }

    it { should validate_presence_of(:volume) }
  end

  describe 'assocations' do
    it { should belong_to(:user) }
  end
end
