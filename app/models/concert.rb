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

  def self.search(query)
    joins(:bands)
      .where("concerts.name ILIKE ?", "%#{query}%")
      .or(Concert.where("concerts.genre_tags ILIKE ? ", "%#{query}%"))
      .or(Concert.joins(:bands).where("bands.name ILIKE ? ", "%#{query}%"))
      .uniq
  end

  def start_day
    start_time.to_date
  end

  def duration_minutes
    gigs.map(&:duration_minutes).sum
  end

  def genre_parameters
    genre_tags.split(",").map(&:parameterize).join(",")
  end

  def unsold_ticket_count
    tickets.unsold.count
  end

  def sold_out?
    unsold_ticket_count.zero?
  end

  def sell_out!
    tickets.update_all(status: :purchased, user: User.hoarder)
  end

  def find_ticket_at(row:, number:)
    tickets.find { |ticket| ticket.row == row && ticket.number == number }
  end

  def self.random_purchase_all!(min = 10, max = 30)
    Concert.find_each { |concert| concert.random_purchase!(min, max) }
  end

  def random_purchase!(min = 10, max = 30)
    purchase = rand(min..max)

    purchase.times do
      tickets.unsold.sample.update(status: :purchased, user: User.hoarder)
    end
  end

  def rows(tickets_to_buy_count: 1)
    tickets.group_by(&:row).map do |key, value|
      row_at(
        tickets: value.sort_by(&:number),
        number: key.to_i,
        tickets_to_buy_count:
      )
    end.sort_by(&:number)
  end

  def row_at(tickets:, number:, tickets_to_buy_count:)
    Row.new(
      tickets:,
      number:,
      tickets_to_buy_count:
    )
  end

  def tickets_in_row(row)
    tickets.select { |ticket| ticket.row == row }.sort_by(&:number)
  end

  def broadcast_schedule_change
    ActionCable.server.broadcast(
      "schedule",
      { concerts: [{ concertId: id, ticketsRemaining: tickets.unsold.count }] }
    )
  end

end
