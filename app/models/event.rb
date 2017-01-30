class Event < ActiveRecord::Base
  extend FriendlyId
  friendly_id :title, use: [:slugged, :finders]

  has_many :tickets
  accepts_nested_attributes_for :tickets
end
