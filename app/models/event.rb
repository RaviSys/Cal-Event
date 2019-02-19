class Event < ApplicationRecord
  include GoogleCalendarApi
  
  CALENDAR_ID = 'primary'

  belongs_to :user, optional: true
  has_many :guests, dependent: :destroy
  accepts_nested_attributes_for :guests, reject_if: :all_blank, allow_destroy: true

  acts_as_taggable_on :tags

  validates :title, presence: true

  before_create :set_default_timing

  # Event Filter Scopes
  scope :upcoming_events, -> { where('start_date > ?', DateTime.now) }  
  scope :past_events, -> { where('end_date < ?', DateTime.now) }  
  scope :current_week_events, -> { where('start_date >= ? AND end_date <= ?',current_week_beginning, current_week_ending) }
  scope :next_week_events, -> { where('start_date >= ? AND end_date <= ?',next_week_beginning, next_week_ending) }
  scope :current_month_events, -> { where('start_date >= ? AND end_date <= ?',current_month_beginning, current_month_ending) }
  scope :next_month_events, -> { where('start_date >= ? AND end_date <= ?',next_month_beginning, next_month_ending) }

  def set_default_timing
    if self.start_date.nil? && self.end_date.nil?
      self.start_date = DateTime.now
      self.end_date = DateTime.now + 1.hour
    end
  end

  def self.current_week_beginning
    DateTime.now.beginning_of_week
  end

  def self.current_week_ending
    DateTime.now.end_of_week
  end

  def self.next_week_beginning
    DateTime.now.end_of_week + 1.day
  end

  def self.next_week_ending
    (DateTime.now.end_of_week + 1.day).end_of_week
  end

  def self.current_month_beginning
    DateTime.now.beginning_of_month
  end

  def self.current_month_ending
    DateTime.now.end_of_month
  end

  def self.next_month_beginning
    DateTime.now.end_of_month + 1.day
  end

  def self.next_month_ending
    (DateTime.now.end_of_month + 1.day).end_of_month
  end

end
