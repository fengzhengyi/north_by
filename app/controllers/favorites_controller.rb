class FavoritesController < ApplicationController
  before_action :set_favorite, only: %i[ destroy ]

  def index
    render partial: 'favorites/count' if params[:count_only]
  end

  # POST /favorites or /favorites.json
  def create
    @favorite = Favorite.create(user: current_user, concert_id: params[:concert_id])

    respond_to(&:turbo_stream)
  end

  # DELETE /favorites/1 or /favorites/1.json
  def destroy
    @favorite.destroy!

    respond_to(&:turbo_stream)
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_favorite
    @favorite = Favorite.find(params[:id])
  end
end
