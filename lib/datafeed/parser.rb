require '~/shastic_challenge/lib/constants'

class Parser
  include Constants

  def initialize(raw_data)
    @raw_data = raw_data
    @parsed_visits_data = []
  end

  def parse
    @raw_data.each do |raw_entry|
      @parsed_visits_data << parse_raw_visit(raw_entry)
    end

    @parsed_visits_data
  end

  private

  def parse_raw_visit(raw_entry)
    visit_attrs = {}
    Constants::VISIT_MAPPING.each_pair do |key, value|
      visit_attrs[key] = raw_entry[value]
    end
    action_details = raw_entry['actionDetails']
    visit_attrs[:pageviews_attrs] = parse_raw_pageviews(action_details)
    visit_attrs
  end

  def parse_raw_pageviews(raw_pageviews)
    parsed_pageviews = []
    raw_pageviews.each_with_index do |raw_entry, position|
      pageview_attributes = {}
      Constants::PAGEVIEW_MAPPING.each_pair do |key, value|
        pageview_attributes[key] = raw_entry[value]
      end
      pageview_attributes[:position] = position
      parsed_pageviews << pageview_attributes
    end
    parsed_pageviews
  end
end
