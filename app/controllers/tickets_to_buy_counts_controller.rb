class TicketsToBuyCountsController < ApplicationController
  def update
    @venue = Venue.find(params[:venue_id])
    @concert = Concert.find(params[:concert_id])
    @user = current_user
    Turbo::StreamsChannel.broadcast_stream_to(
      @concert, @user,
      content: render(
        partial: 'tickets_to_buy_counts/update',
        locals: {
          venue: @venue,
          concert: @concert,
          user: @user,
          tickets_to_buy_count: params[:tickets_to_buy_count].to_i
        }
      )
    )
    respond_to do |format|
      format.turbo_stream { head :ok }
    end
  end
end
