require "google/apis/calendar_v3"
require "google/api_client/client_secrets.rb"

class Event < ApplicationRecord

  has_many :guests, dependent: :destroy
  accepts_nested_attributes_for :guests, reject_if: :all_blank, allow_destroy: true

  CALENDAR_ID = 'primary'

  belongs_to :user, optional: true

  def get_google_calendar_client current_user
    client = Google::Apis::CalendarV3::CalendarService.new
    return unless (current_user.present? && current_user.access_token.present? && current_user.refresh_token.present?)

    secrets = Google::APIClient::ClientSecrets.new({
      "web" => {
        "access_token" => current_user.access_token,
        "refresh_token" => current_user.refresh_token,
        "client_id" => "1082001533559-pjtf3u5gavf30rtesorrsbb7fqkoi3e5.apps.googleusercontent.com",
        "client_secret" => "SGujY70SNUQ0MonMdZzV0yxW"
      }
    })
    begin
      client.authorization = secrets.to_authorization
      client.authorization.grant_type = "refresh_token"

      if current_user.expired?
        client.authorization.refresh!
        current_user.update_attributes(
          access_token: client.authorization.access_token,
          refresh_token: client.authorization.refresh_token,
          expires_at: client.authorization.expires_at.to_i
        )
      end
    rescue => e
      raise e.message
    end
    client
  end

  def create_google_event(event, user)
    client = get_google_calendar_client user
    g_event = get_event(event)
    ge = client.insert_event(Event::CALENDAR_ID, g_event)
    event.update(google_event_id: ge.id)
  end

  def edit_google_event(event, user)
    # client = get_google_calendar_client user
    # g_event = get_event(event)
    # # event = Google::Apis::CalendarV3::Event.new(event)
    # client.update_event(Event::CALENDAR_ID, g_event.id, g_event)
  end

  def get_event(event)
    event = Google::Apis::CalendarV3::Event.new({
      summary: event.title,
      location: '800 Howard St., San Francisco, CA 94103',
      description: event.description,
      start: {
        date_time: event.start_date.to_datetime.to_s,
        time_zone: 'Asia/Tokyo', 
      },
      end: {
        date_time: event.end_date.to_datetime.to_s,
        time_zone: 'Asia/Tokyo',
      },
      attendees: event.guests.map {|guest| {email: guest.email}},
      reminders: {
        use_default: false
      }
    })
    # result = client.insert_event(Event::CALENDAR_ID, event)
  end

  def delete_google_event(google_event_id, user)
    client = get_google_calendar_client user
    client.delete_event(Event::CALENDAR_ID, google_event_id)
  end

  def get_google_event(event_id, user)
    client = get_google_calendar_client user
    g_event = client.get_event(Event::CALENDAR_ID, event_id)
    puts g_event
  end


end
