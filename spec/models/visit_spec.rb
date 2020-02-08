require '/app/models/visit'

describe Visit do
  it 'should clear invalid evid' do
    visit = Visit.create(evid: 'invalid evid')
    expect(visit.evid).to eq('')
  end

  it 'should create pageviews' do
    visit = Visit.new
    visit.pageviews_attrs = [{ timestamp: '123456' }, { timestamp: '123457' }]
    visit.save
    expect(visit.pageviews.count).to eq(2)
  end
end
