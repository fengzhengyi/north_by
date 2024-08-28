# == Schema Information
#
# Table name: shopping_carts
#
#  id         :bigint           not null, primary key
#  user_id    :bigint           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class ShoppingCart < ApplicationRecord
  belongs_to :user

  def add_tickets(
    concert_id:,
    row:,
    seat_number:,
    tickets_to_buy_count:,
    status:
  )
    seat_range = seat_number...(seat_number + tickets_to_buy_count)
    tickets = Ticket.where(
      concert_id: concert_id,
      row: row,
      number: seat_range
    )
    tickets.update(status: status, user: user)
  end

  def clear(concert_id:, row:, seat_number:, tickets_to_buy_count:, status:)
    seat_range = seat_number...(seat_number + tickets_to_buy_count)
    tickets = Ticket.where(
      concert_id: concert_id,
      row: row,
      number: seat_range
    )
    tickets.each do |ticket|
      ticket.update(status: :unsold, user: nil)
    end
  end
  
  def clear_all(concert_id:, user_id:)
    tickets = Ticket.where(concert_id: concert_id, user_id: user_id)
    tickets.each do |ticket|
      ticket.update(status: :unsold, user: nil)
    end
  end
end
