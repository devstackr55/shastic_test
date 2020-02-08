require '/app/lib/datafeed/client'
require '/app/config/initializers/base_datafeed_url_loader'

describe Client do
  it 'should fetch data and return parsed json' do
    client = Client.new("#{BASE_DATAFEED_URL}5e3bf656300000223c2149a9")
    fetched_data = client.fetch
    raw_path = '/app/samples/api_response.json'
    response_file = File.expand_path(raw_path)
    expected_response = File.read(response_file)
    expect(fetched_data).to eq(JSON.parse(expected_response))
  end
end
