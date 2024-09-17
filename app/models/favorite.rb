# == Schema Information
#
# Table name: favorites
#
#  id         :bigint           not null, primary key
#  user_id    :bigint           not null
#  concert_id :bigint           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Favorite < ApplicationRecord
  belongs_to :user
  belongs_to :concert

  after_create_commit -> do
    # broadcast_append_later_to(user, :favorites, target: "favorite_concerts")
    # Turbo::StreamsChannel.broadcast_stream_to(
    #   user, :favorites,
    #   content: ApplicationController.render(
    #     :turbo_stream,
    #     partial: "favorites/create",
    #     locals: { favorite: self, user: user }
    #   )
    # )
    broadcast_render_later_to(
      user, :favorites,
      partial: "favorites/create",
      locals: { favorite: self, user: }
    )
  end

  after_destroy_commit -> do
    # broadcast_remove_to(user, :favorites)
    # Turbo::StreamsChannel.broadcast_stream_to(
    #   user, :favorites,
    #   content: ApplicationController.render(
    #     :turbo_stream,
    #     partial: "favorites/destroy",
    #     locals: { favorite: self, user: user }
    #   )
    # )
    broadcast_render_to(
      user, :favorites,
      partial: "favorites/destroy",
      locals: { favorite: self, user: }
    )
  end
end
