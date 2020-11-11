class DomainStatusUpdatesChannel < ApplicationCable::Channel
  def subscribed
    stream_from 'crawler'
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
