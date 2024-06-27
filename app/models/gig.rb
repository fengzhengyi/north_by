class Gig < ApplicationRecord
  belongs_to :concert
  belongs_to :band
end
