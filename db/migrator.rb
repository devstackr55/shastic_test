require 'yaml'
require '~/shastic_challenge/db/migrate/visits'
require '~/shastic_challenge/db/migrate/pageviews'

class Migrator
  def initialize
    db_file_path = File.expand_path('~/shastic_challenge/config/database.yml')
    db_config_file = File.open(db_file_path)
    db_config = YAML.safe_load(db_config_file)

    ActiveRecord::Base.establish_connection(db_config)
  end

  def migrate
    CreateVisitsTable.migrate(:up)
    CreatePageviewsTable.migrate(:up)
  end
end
