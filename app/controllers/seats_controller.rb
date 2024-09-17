class SeatsController < ApplicationController
  before_action :load_data, only: %i[update destroy]

  def update
    @cart.add_tickets(
      concert_id: params[:concert_id].to_i,
      row: params[:row_number].to_i,
      seat_number: params[:seat_number].to_i,
      tickets_to_buy_count: params[:tickets_to_buy_count].to_i,
      status: 'held'
    )
    load_row
    Turbo::StreamsChannel.broadcast_stream_to(
      @concert, @user,
      content: ApplicationController.render(
        :turbo_stream,
        partial: "seats/update",
        locals: { concert: @concert, user: @user, row: @row }
      )
    )
    @concert.broadcast_schedule_change
    respond_to do |format|
      format.turbo_stream { head(:ok) }
    end

  end

  def destroy
    @cart.clear(
      concert_id: params[:concert_id].to_i,
      row: params[:row_number].to_i,
      seat_number: params[:seat_number].to_i,
      tickets_to_buy_count: params[:tickets_to_buy_count].to_i,
      status: 'unsold'
    )
    load_row
    Turbo::StreamsChannel.broadcast_stream_to(
      @concert, @user,
      content: ApplicationController.render(
        :turbo_stream,
        partial: "seats/update",
        locals: { concert: @concert, user: @user, row: @row }
      )
    )
    @concert.broadcast_schedule_change
    respond_to do |format|
      format.turbo_stream { head(:ok) }
    end
  end

  private

  def load_data
    @user = current_user
    @cart = ShoppingCart.find_or_create_by(user_id: params[:user_id])
    @concert = Concert.find(params[:concert_id])
  end

  def load_row
    @row = @concert.row_at(
      tickets: @concert.tickets_in_row(params[:row_number].to_i),
      number: params[:row_number].to_i,
      tickets_to_buy_count: params[:tickets_to_buy_count].to_i
    )
  end
end
