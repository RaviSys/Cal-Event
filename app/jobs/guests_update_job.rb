class GuestsUpdateJob < ApplicationJob
  include GoogleCalendarApi

  queue_as :default

  def perform(current_user)
    # client = get_google_client
  end
end
