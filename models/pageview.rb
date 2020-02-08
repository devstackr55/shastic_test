require '~/shastic_challenge/models/application_record'

class Pageview < ApplicationRecord
  belongs_to :visit

  default_scope { order(:timestamp) }

  validates :timestamp, uniqueness: { scope: %i[url visit_id] }
end
