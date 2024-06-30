class FavoritesController < ApplicationController
  before_action :set_favorite, only: %i[ destroy ]

  # POST /favorites or /favorites.json
  def create
    Favorite.create(user: current_user, concert_id: favorite_params[:concert_id])

    redirect_to :root
  end

  # DELETE /favorites/1 or /favorites/1.json
  def destroy
    @favorite.destroy!

    redirect_to :root
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_favorite
    @favorite = Favorite.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def favorite_params
    params.require(:favorite).permit(:concert_id)
  end
end
