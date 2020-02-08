require 'yaml'
require '/app/db/migrate/visits'
require '/app/db/migrate/pageviews'

class Migrator
  def initialize(env = 'development')
    db_file_path = File.expand_path('/app/config/database.yml')
    db_config_file = File.open(db_file_path)
    db_config = YAML.safe_load(db_config_file, [], [], true)
    create_db(db_config, env)
    ActiveRecord::Base.establish_connection(db_config[env])
  end

  def migrate(action = :up)
    load_tables(action).each { |table| table.migrate(action) }
  end

  private

  def create_db(db_config, env)
    ActiveRecord::Base.establish_connection(db_config['primary'])
    query = "CREATE DATABASE IF NOT EXISTS shastic_challenge_#{env}"
    ActiveRecord::Base.connection.execute(query)
  end

  def load_tables(action)
    tables = Dir.glob('/app/db/migrate/*.rb').map do |file|
      parsed_name = file.split('/app/db/migrate/').last.split('.rb').first
      "Create#{parsed_name.capitalize}Table".constantize
    end
    return tables if action == :up

    tables.reverse
  end
end
