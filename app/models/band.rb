# == Schema Information
#
# Table name: bands
#
#  id          :bigint           not null, primary key
#  name        :string
#  description :text
#  genre_tags  :text
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
class Band < ApplicationRecord
end
