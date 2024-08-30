class ScheduleChannel < ApplicationCable::Channel
  def subscribed
    steam_from "schedule"
  end

  def unsubscribed
  end
end
