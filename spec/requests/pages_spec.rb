require 'rails_helper'

RSpec.describe 'Pages', type: :request do
  it 'should get the index page' do
    get root_path

    expect(response).to have_http_status(200)
  end
end
