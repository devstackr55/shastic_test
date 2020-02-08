require '/app/lib/services/visits_creator'

describe VisitsCreator do
  it 'should create visits and pageviews' do
    raw_path = '/app/samples/parsed_visits.json'
    test_file = File.expand_path(raw_path)
    test_visits_data = File.read(test_file)
    visit_creator = VisitsCreator.new(JSON.parse(test_visits_data))
    created_visits = visit_creator.run
    expect(created_visits.count).to eq(2)
    expect(created_visits.map(&:pageviews).flatten.count).to eq(10)
  end
end
