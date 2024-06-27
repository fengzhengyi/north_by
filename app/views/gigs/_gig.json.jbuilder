json.extract! gig, :id, :concert_id, :band_id, :order, :duration_minutes, :created_at, :updated_at
json.url gig_url(gig, format: :json)
