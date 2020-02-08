module Constants
  VISIT_MAPPING = {
    evid: 'referrerName',
    vendor_site_id: 'idSite',
    vendor_visit_id: 'idVisit',
    visit_ip: 'visitIp',
    vendor_visitor_id: 'visitoriId'
  }.freeze

  PAGEVIEW_MAPPING = {
    url: 'url',
    title: 'pageTitle',
    time_spent: 'timeSpent',
    timestamp: 'timestamp'
  }.freeze
end
