# == Schema Information
#
# Table name: concerts
#
#  id          :bigint           not null, primary key
#  name        :string
#  description :text
#  genre_tags  :text
#  start_time  :datetime
#  venue_id    :bigint           not null
#  ilk         :string
#  access      :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
class Concert < ApplicationRecord
  belongs_to :venue

  enum ilk: {concert: "concert", meet_n_greet: "meet_n_greet", battle: "battle"}
  enum access: {general: "general", members: "members", vips: "vips"}
end
