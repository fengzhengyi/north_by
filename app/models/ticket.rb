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
  belongs_to :user
end
