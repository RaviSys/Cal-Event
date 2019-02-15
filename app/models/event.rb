class Event < ApplicationRecord
  include GoogleCalendarApi

  belongs_to :user, optional: true
  has_many :guests, dependent: :destroy
  accepts_nested_attributes_for :guests, reject_if: :all_blank, allow_destroy: true

  CALENDAR_ID = 'primary'

  validates :title, :description, :start_date, :end_date, :venue, presence: true

  validate :guests_must_be_present, on: :create

  def guests_must_be_present
    if guests.count < 1
      errors.add(:you, "can not create events without adding any guest. At least one guest must be present for event")
    end
  end

end
