# frozen_string_literal: true

class Seat
  include ActiveModel::Model
  include ActiveModel::Conversion
  attr_accessor :ticket, :row

  STATUSES = %w[unsold unavailable held purchased refunded invalid].freeze

  delegate :number, :unavailable?, to: :ticket

  def status(user)
    return 'invalid' if !row.seat_available?(self) && !unavailable?
    return 'other' if ticket.user && ticket.user != user

    ticket.status
  end

  def clickable?(user)
    status(user) == 'unsold'
  end

  def id
    "#{row.number}_#{number}"
  end

  def row_seat
    "#{row.number}x#{ticket.number}"
  end

  def hover_color_for(user)
    return 'hover:bg-blue-100' if status(user) == 'unsold'
  end

  def color_for(user)
    case status(user)
    when 'unsold' then 'bg-white'
    when 'invalid' then 'bg-yellow-500'
    when 'other' then 'bg-red-600'
    when 'purchased' then 'bg-green-600'
    when 'held' then 'bg-green-600'
    else
      'bg-white'
    end
  end
end
