module ApplicationHelper
  
  def gravatar_for(user, options = { size: 200})
   gravatar_id = Digest::MD5::hexdigest(user.email.downcase)
   size = options[:size]
  #  gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}?s=#{size}"
  gravatar_url = "https://gravatar.com/avatar/#{gravatar_id}?s=#{size}"
  #  image_tag(gravatar_url, alt: user.name, class: "border-radius-50")
  image_tag(gravatar_url, alt: user.name, class: "gravatar")
 end

 def markdown_to_html(text)
   Kramdown::Document.new(text, input: "GFM").to_html
 end

 def listing_author(listing)
   user_signed_in? && current_user.id == listing.user_id
 end

 def listing_type(listing_type)
    if listing_type == "House"
      content_tag :span, "#{listing_type}", class: "tag is-primary"
    elsif listing_type == "Apartment"
      content_tag :span, "#{listing_type}", class: "tag is-link"
    elsif listing_type == "Room"
      content_tag :span, "#{listing_type}", class: "tag is-warning"
    elsif listing_type == "Dorm"
      content_tag :span, "#{listing_type}", class: "tag is-info"
    else
      ""
    end
  end
  
  def comment
  end

end