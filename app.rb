require '~/shastic_challenge/db/migrator'
require '~/shastic_challenge/config/initializers/base_datafeed_url_loader'
require '~/shastic_challenge/lib/datafeed/client'
require '~/shastic_challenge/lib/datafeed/parser'
require '~/shastic_challenge/lib/services/visits_creator'

def call
  begin
    migrator = Migrator.new
    migrator.migrate
  rescue StandardError => e
    p "Unable to migrate database: #{e.message}"
    return
  end

  begin
    datafeed_url = "#{BASE_DATAFEED_URL}5e3bf656300000223c2149a9"
    client = Client.new(datafeed_url)
    data_parser = Parser.new(client.fetch)
    visits_creator = VisitsCreator.new(data_parser.parse)
    visits_creator.run
  rescue StandardError => e
    p "Unable to populate data: #{e.message}"
  end
end

call
