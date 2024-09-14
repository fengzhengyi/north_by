class ScheduleChannel < ApplicationCable::Channel
  def subscribed
    steam_from "schedule"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
