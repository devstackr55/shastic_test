require '/app/lib/datafeed/parser'
require 'pry'

describe Parser do
  it 'should receive raw data and return parsed visits' do
    test_file = File.expand_path('/app/samples/test_visits.json')
    test_visits_data = File.read(test_file)
    parser = Parser.new(JSON.parse(test_visits_data))
    parsed_visits_data = parser.parse.as_json
    raw_path = '/app/samples/parsed_visits.json'
    parsed_visits_file = File.expand_path(raw_path)
    parsed_visits_content = File.read(parsed_visits_file)
    expected_parsed_visits = JSON.parse(parsed_visits_content)
    expect(parsed_visits_data).to eq(expected_parsed_visits)
  end
end
