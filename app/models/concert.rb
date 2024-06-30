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

  has_many :gigs,
           -> { order(order: :asc) },
           dependent: :destroy,
           inverse_of: :concert
  has_many :bands, through: :gigs
  has_many :tickets, dependent: :destroy

  enum ilk: { concert: "concert", meet_n_greet: "meet_n_greet", battle: "battle" }
  enum access: { general: "general", members: "members", vips: "vips" }

  def start_day
    start_time.to_date
  end

  def unsold_ticket_count
    tickets.unsold.count
  end

  def sold_out?
    unsold_ticket_count.zero?
  end

end
