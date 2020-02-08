class EvidValidator < ActiveModel::Validator
  # rubocop:disable Layout/LineLength
  EVID_REGEX = Regexp.new('/\A[A-z0-9]{8}-[A-z0-9]{4}-[A-z0-9]{4}-[A-z0-9]{4}-[A-z0-9]{12}\z/').freeze
  # rubocop:enable Layout/LineLength

  def validate(record)
    return if EVID_REGEX.match?(evid = record.evid)

    record.evid = EVID_REGEX.match?(evid = evid&.gsub('evid_', '')) ? evid : ''
  end
end
