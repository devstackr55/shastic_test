require '~/shastic_challenge/models/application_record'
require '~/shastic_challenge/models/pageview'
require '~/shastic_challenge/models/concerns/evid_validator'

class Visit < ApplicationRecord
  attr_accessor :pageviews_attrs

  has_many :pageviews, dependent: :destroy

  validates_with EvidValidator

  after_create :create_pageviews, if: proc { |v| v.pageviews_attrs.present? }

  private

  def create_pageviews
    pageviews_attrs.each { |pageview_attr| pageviews.create(pageview_attr) }
  end
end
