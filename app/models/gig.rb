# == Schema Information
#
# Table name: gigs
#
#  id               :bigint           not null, primary key
#  concert_id       :bigint           not null
#  band_id          :bigint           not null
#  order            :integer
#  duration_minutes :integer
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#
class Gig < ApplicationRecord
  belongs_to :concert
  belongs_to :band
end
