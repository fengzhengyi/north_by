json.extract! concert, :id, :name, :description, :genre_tags, :start_time, :venue_id, :ilk, :access, :created_at, :updated_at
json.url concert_url(concert, format: :json)
