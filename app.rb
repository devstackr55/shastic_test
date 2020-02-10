require '/app/db/migrator'
require '/app/lib/datafeed/client'
require '/app/lib/datafeed/parser'
require '/app/lib/services/visits_creator'

def call
  begin
    migrator = Migrator.new
    migrator.migrate
  rescue StandardError => e
    p "Unable to migrate database: #{e.message}"
    return
  end

  begin
    datafeed_url = "#{ENV['BASE_DATAFEED_URL']}5e3bf656300000223c2149a9"
    client = Client.new(datafeed_url)
    data_parser = Parser.new(client.fetch)
    visits_creator = VisitsCreator.new(data_parser.parse)
    visits_creator.run
  rescue StandardError => e
    p "Unable to populate data: #{e.message}"
  end
end
