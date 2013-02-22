module AnalyticsTracker

  def self.included(base)
    base.before_filter :track_analytics
  end

  def track_analytics
    track_page_view
    track_first_visit
    track_unique_daily_visit
  end

  def track_page_view
    track_event(:page_view)
  end

  def track_first_visit
    unless cookies[:first_visit]
      track_event(:first_visit)
      cookies[:first_visit] = { value: :visited }
    end
  end

  def track_unique_daily_visit
    unless cookies[:unique_daily_visit]
      track_event(:daily_visit)
      cookies[:unique_daily_visit] = { value: :visited, expires: DateTime.tomorrow.beginning_of_day }
    end
  end

  def track_event(event_name)
    AnalyticsEvent.track(name: event_name, user: current_user, request: request)
  end
end
