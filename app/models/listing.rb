class Listing < ApplicationRecord
  belongs_to :user
  mount_uploader :avatar, AvatarUploader
  has_many_attached :images, dependent: :destroy
  LISTING_TYPES = ["House", "Apartment", "Room", "Dorm"]

  def working_url?(url)
    uri = URI.parse(url)
    uri.is_a?(URI::HTTP) && !uri.host.nil?
    rescue URI::InvalidURIError
    false
  end
end
