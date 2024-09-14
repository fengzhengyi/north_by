# == Schema Information
#
# Table name: tickets
#
#  id               :bigint           not null, primary key
#  concert_id       :bigint           not null
#  row              :integer
#  number           :integer
#  user_id          :bigint           not null
#  status           :string
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  ticket_order_id  :bigint
#  shopping_cart_id :bigint
#
class Ticket < ApplicationRecord
  belongs_to :concert
  belongs_to :user, optional: true
  belongs_to :ticket_order, optional: true
  belongs_to :shopping_cart, optional: true

  after_update_commit lambda {
                        Turbo::StreamsChannel.broadcast_stream_to(
                          concert,
                          content: { seat: id, status: }.to_json
                        )
                      }

  enum status: {
    unsold: 'unsold',
    held: 'held',
    purchased: 'purchased',
    refunded: 'refunded'
  }

  def toggle_for(user)
    return unless user
    return if self.user && self.user != user

    case status
    when 'unsold'
      update(status: 'held', user:)
    when 'held'
      update(status: 'unsold', user:)
    end
  end

  def self.for_concert(concert_id)
    return Ticket.all unless concert_id

    Ticket.where(concert_id:)
          .order(row: :asc, number: :asc)
          .all
          .reject(&:refunded?)
  end

  def self.user_for_concert(concert_id, user_id)
    return [] unless user_id

    for_concert(concert_id).select { |ticket| ticket.user_id == user_id }
  end

  def self.grouped_for_concert(concert_id)
    return [] unless concert_id

    for_concert(concert_id).map(&:to_concert_h).group_by { |t| t[:row] }.values
  end

  def to_concert_h
    { id:, row:, number:, status: }
  end

  def self.data_for_concert(concert_id)
    for_concert(concert_id).select(&:unavailable?).map(&:to_concert_h)
  end

  def unavailable?
    held? || purchased?
  end
end
