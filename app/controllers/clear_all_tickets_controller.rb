class ClearAllTicketsController < ApplicationController
  def destroy
    @cart = ShoppingCart.find_or_create_by(user_id: params[:user_id])
    @concert = Concert.find(params[:concert_id])
    @user = current_user
    @cart.clear_all(concert_id: @concert.id, user_id: @user.id)
    @concert.broadcast_schedule_change
  end
end
