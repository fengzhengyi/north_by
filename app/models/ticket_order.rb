# == Schema Information
#
# Table name: ticket_orders
#
#  id               :bigint           not null, primary key
#  concert_id       :bigint           not null
#  status           :string
#  count            :integer
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  shopping_cart_id :bigint
#
class TicketOrder < ApplicationRecord
  belongs_to :concert
end
