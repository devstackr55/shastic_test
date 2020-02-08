require 'httparty'

class Client
  def initialize(datafeed_url)
    @datafeed_url = datafeed_url
    @fetched_data = {}
  end

  def fetch
    response = HTTParty.get(@datafeed_url)
    @fetched_data = parse(response)
  end

  private

  def parse(response)
    JSON.parse(response.body)
  end
end
