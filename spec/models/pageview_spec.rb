require '~/shastic_challenge/models/pageview'
require '~/shastic_challenge/models/visit'

describe Pageview do
  it 'should disallow duplicate timestamp' do
    visit = Visit.create
    pageview_attrs = { url: 'www.example.com', timestamp: '123456' }
    visit.pageviews.create(pageview_attrs)
    dup_pageview = visit.pageviews.new(pageview_attrs)
    expect(dup_pageview.valid?).to eq(false)
  end

  it 'should return pageviews in ascending order according to timestamp' do
    visit = Visit.new
    visit.pageviews_attrs = [{ timestamp: '000001' }, { timestamp: '000000' }]
    visit.save
    expect(visit.pageviews.pluck(:timestamp)).to eq([0, 1])
  end
end
