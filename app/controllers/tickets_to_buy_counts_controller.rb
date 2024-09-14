class TicketsToBuyCountsController < ApplicationController
  def update
    @venue = Venue.find(params[:venue_id])
    @concert = Concert.find(params[:concert_id])
    @user = current_user
  end
end
