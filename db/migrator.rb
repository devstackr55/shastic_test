require 'yaml'
require '~/shastic_challenge/db/migrate/visits'
require '~/shastic_challenge/db/migrate/pageviews'

class Migrator
  def initialize(env = 'development')
    db_file_path = File.expand_path('~/shastic_challenge/config/database.yml')
    db_config_file = File.open(db_file_path)
    db_config = YAML.safe_load(db_config_file, [], [], true)

    ActiveRecord::Base.establish_connection(db_config[env])
  end

  def migrate(action = :up)
    case action
    when :up
      CreateVisitsTable.migrate(action)
      CreatePageviewsTable.migrate(action)
    else
      CreatePageviewsTable.migrate(action)
      CreateVisitsTable.migrate(action)
    end
  end
end
