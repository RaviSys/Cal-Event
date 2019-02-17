class Event < ApplicationRecord
  include GoogleCalendarApi

  belongs_to :user, optional: true
  has_many :guests, dependent: :destroy
  accepts_nested_attributes_for :guests, reject_if: :all_blank, allow_destroy: true

  acts_as_taggable_on :tags

  CALENDAR_ID = 'primary'

  validates :title, presence: true

  before_create :set_default_timing

  def set_default_timing
    if self.start_date.nil? && self.end_date.nil?
      self.start_date = DateTime.now
      self.end_date = DateTime.now + 1.hour
    end
  end

  # validate :guests_must_be_present, on: :create

  # def guests_must_be_present
  #   if guests.count < 1
  #     errors.add(:you, "can not create events without adding any guest. At least one guest must be present for event")
  #   end
  # end

end
