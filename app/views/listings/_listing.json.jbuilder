json.extract! listing, :id, :title, :description, :listing_type, :location, :author, :created_at, :updated_at
json.url listing_url(listing, format: :json)
