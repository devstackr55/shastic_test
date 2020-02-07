require '~/shastic_challenge/db/migrator'

def call
  migrator = Migrator.new
  migrator.migrate
end

call
