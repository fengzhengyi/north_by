class ConcertChannel < ApplicationCable::Channel
  def subscribed
    stream_from "concert_#{params[:concertId]}"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

end
