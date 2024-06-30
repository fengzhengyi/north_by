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

  enum status: {
    unsold: 'unsold',
    held: 'held',
    purchased: 'purchased',
    refunded: 'refunded'
  }
  
end
