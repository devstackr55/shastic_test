require 'yaml'
require '/app/db/migrate/visits'
require '/app/db/migrate/pageviews'

class Migrator
  def initialize(env = 'development')
    db_config = load_database_yml(env)
    create_db(db_config, env)
    ActiveRecord::Base.establish_connection(db_config[env])
  end

  def migrate(action = :up)
    load_tables(action).each { |table| table.migrate(action) }
  end

  private

  def load_database_yml(env)
    db_config_file = File.read('/app/config/database.yml')
    db_config_file.gsub!(/\${([^}]+)}/, ENV["#{env.upcase}_DATABASE"])
    YAML.safe_load db_config_file
  end

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
