class AnalyticsEvent < ActiveRecord::Base

  validates :name, presence: true
  validates :user, presence: true
  validates :url, presence: true
  validates :count, presence: true

  def self.track(args={})
    name = args[:name]
    request = args[:request]
    user = fetch_user(args)
    url = request.path

    event = AnalyticsEvent.where(name: name, user: user, url: url).first_or_initialize do |e|
      e.name = name
      e.user = user
      e.url = url
      e.count = 0
    end

    event.count += 1
    event.save
    event
  end

  private

  def self.fetch_user(args)
    user = args[:user]
    if user
      user.id
    else
      args[:request].remote_ip
    end
  end

end
