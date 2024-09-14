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
    result = Ticket.data_for_concert(params[:concert_id])
    ActionCable.server.broadcast("concert_#{params[:concert_id]}", result)
    @concert.broadcast_schedule_change
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
    result = Ticket.data_for_concert(params[:concert_id])
    ActionCable.server.broadcast("concert_#{params[:concert_id]}", result)
    @concert.broadcast_schedule_change
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
