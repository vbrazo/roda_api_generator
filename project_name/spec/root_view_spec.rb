require 'spec_helper'

RSpec.describe 'Do a GET request in the root_path' do
  it 'should create a user' do
    get '/'

    expect(last_response.status).to eq(200)
    expect(last_response.body).to eq('Nothing Here')
  end
end
