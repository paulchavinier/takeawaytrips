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
    "beauty_salon" => "Shop",
    "bicycle_store" => "Shop",
    "book_store" => "Shop",
    "clothing_store" => "Shop",
    "convenience_store" => "Shop",
    "department_store" => "Shop",
    "electronics_store" => "Shop",
    "florist" => "Shop",
    "furniture_store" => "Shop",
    "grocery_or_supermarket" => "Shop",
    "hardware_store" => "Shop",
    "home_goods_store" => "Shop",
    "jewelry_store" => "Shop",
    "pet_store" => "Shop",
    "pharmacy" => "Shop",
    "shoe_store" => "Shop",
    "shopping_mall" => "Shop",
    "store" => "Shop",
    "amusement_park" => "Do",
    "aquarium" => "Do",
    "art_gallery" => "Do",
    "bowling_alley" => "Do",
    "casino" => "Do",
    "church" => "Do",
    "gym" => "Do",
    "library" => "Do",
    "movie_theater" => "Do",
    "museum" => "Do",
    "park" => "Do",
    "spa" => "Do",
    "zoo" => "Do",

  }

  CATEGORIES_MAPPING = {
    "Eat" => ["bakery", "cafe", "meal_takeaway", "meal_delivery", "food", "restaurant"],
    "Sleep" => ["campground", "lodging"],
    "Drink" => ["liquor_store", "night_club", "bar"],
    "Shop" => ["beauty_salon", "bicycle_store", "book_store", "clothing_store", "convenience_store", "department_store", "electronics_store", "florist", "furniture_store", "grocery_or_supermarket", "hardware_store", "home_goods_store", "jewelry_store", "pet_store", "pharmacy", "shoe_store", "shopping_mall", "store"],
    "Do" => ["amusement_park", "aquarium", "art_gallery", "bowling_alley", "casino", "church", "gym", "library", "movie_theater", "museum", "park", "spa", "zoo"],
    "All" => ["amusement_park", "aquarium", "art_gallery", "bowling_alley", "casino", "church", "gym", "library", "movie_theater", "museum", "park", "spa", "zoo", "beauty_salon", "bicycle_store", "book_store", "clothing_store", "convenience_store", "department_store", "electronics_store", "florist", "furniture_store", "grocery_or_supermarket", "hardware_store", "home_goods_store", "jewelry_store", "pet_store", "pharmacy", "shoe_store", "shopping_mall", "store", "liquor_store", "night_club", "bar", "campground", "lodging", "bakery", "cafe", "meal_takeaway", "meal_delivery", "food", "restaurant"]
  }

  belongs_to :guide

  validates :name, presence: true

  def choosephoto
    if self.photo.url
      photo
    else
      gphoto
    end
  end

  def opened?(date=Date.current)
    return if opening_hours.empty?
    day_hours = []

    if opening_hours.size == 14
      day = (date.wday * 2) - 2

      day_hours << opening_hours[day].split(': ').last
      day_hours << opening_hours[day + 1]
    else
      day = date.wday - 1
      day_hours << opening_hours[day].split(': ').last
    end

    return false if day_hours == ["Fermé"]
    return true if day_hours == ["Ouvert 24h/24"]

    day_hours.each do |day_hour|
      hours = day_hour.strip.split(" – ")

      hour, minute = hours[0].split(':').map(&:to_i)
      opening_hour = date.to_time.advance(hours: hour, minutes: minute)

      hour, minute = hours[1].split(':').map(&:to_i)
      closing_hour = date.to_time.advance(hours: hour, minutes: minute)

      return true if opening_hour <= Time.current && Time.current <= closing_hour
    end

    return false
  end

end
