require 'spec_helper'

RSpec.describe 'Do a GET request in the root_path' do
  it 'should render root page' do
    get '/'

    expect(last_response.status).to eq(200)
    expect(last_response.body).to eq('Nothing Here')
  end

  it 'should render something_here page' do
    get '/example', email: 'email'

    expect(last_response.status).to eq(200)
    expect(last_response.body).to eq('email')
  end
end
