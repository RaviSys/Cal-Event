class Event < ApplicationRecord
  include GoogleCalendarApi

  belongs_to :user, optional: true
  has_many :guests, dependent: :destroy
  accepts_nested_attributes_for :guests, reject_if: :all_blank, allow_destroy: true

  CALENDAR_ID = 'primary'

end
