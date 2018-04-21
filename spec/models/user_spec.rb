require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'assocations' do
    it { should have_many(:log_entries) }
  end
end
