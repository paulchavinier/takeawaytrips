class Card < ActiveRecord::Base

  mount_uploader :photo, PhotoUploader

  CATEGORIES = {
    "bakery" => "Eat",
    "cafe" => "Eat",
    "meal_delivery" => "Eat",
    "meal_takeaway" => "Eat",
    "food" => "Eat",
    "restaurant" => "Eat",
    "campground" => "Sleep",
    "lodging" => "Sleep",
    "bar" => "Drink",
    "liquor_store" => "Drink",
    "night_club" => "Drink",
  }

  CATEGORIES_MAPPING = {
    "Eat" => ["bakery", "cafe", "meal_takeaway", "meal_delivery", "food", "restaurant"]
  }

  # <% if card.category ==  || card.category == "" || card.category == "" || card.category == "" || card.category == "" || card.category == "" %>
  #   <%=%>
  # <% elsif card.category == "" || card.category == "" %>
  #   <%=""%>
  # <% elsif card.category == "" || card.category == "" || card.category == "" %>
  #   <%=""%>
  # <% elsif card.category == "beauty_salon" || card.category == "bicycle_store" || card.category == "book_store" || card.category == "clothing_store" || card.category == "convenience_store" || card.category == "department_store" || card.category == "electronics_store" || card.category == "florist" || card.category == "furniture_store" || card.category == "grocery_or_supermarket" || card.category == "hardware_store" || card.category == "home_goods_store" || card.category == "jewelry_store" || card.category == "pet_store" || card.category == "pharmacy" || card.category == "shoe_store" || card.category == "shopping_mall" || card.category == "store" %>
  #   <%=""%>
  # <% elsif card.category == "amusement_park" || card.category == "aquarium" || card.category == "art_gallery" || card.category == "bowling_alley" || card.category == "casino" || card.category == "church" || card.category == "gym"  || card.category == "library"  || card.category == "movie_theater"  || card.category == "museum"  || card.category == "park"  || card.category == "place_of_worship"  || card.category == "spa"  || card.category == "zoo"  %>
  #   <%="Do"%>
  # <% elsif %>
  #   <%="Place"%>
  # <%end%>

  belongs_to :guide

  validates :name, presence: true
  validates :formatted_address, presence: true

  def choosephoto
    if self.photo.url
      photo
    else
      gphoto
    end
  end


end
