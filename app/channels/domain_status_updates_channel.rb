class DomainStatusUpdatesChannel < ApplicationCable::Channel
  def subscribed
    stream_from 'crawler'
  end
end
