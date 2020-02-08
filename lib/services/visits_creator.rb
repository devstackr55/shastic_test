require '/app/models/visit'

class VisitsCreator
  def initialize(visits_data)
    @visits_data = visits_data
    @created_visits = Visit.none
  end

  def run
    @created_visits = @visits_data.map { |attrs| Visit.create(attrs) }
  end
end
