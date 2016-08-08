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
    "airport" => "See",
    "amusement_park" => "See",
    "aquarium" => "See",
    "art_gallery" => "See",
    "bowling_alley" => "See",
    "casino" => "See",
    "church" => "See",
    "gym" => "See",
    "library" => "See",
    "movie_theater" => "See",
    "museum" => "See",
    "park" => "See",
    "spa" => "See",
    "zoo" => "See",
    "locality" => "See",
    "administrative_area_level_1" => "See",
    "administrative_area_level_2" => "See",
    "administrative_area_level_3" => "See",
    "administrative_area_level_4" => "See",
    "administrative_area_level_5" => "See",
    "colloquial_area" => "See",
    "country" => "See",
    "floor" => "See",
    "geocode" => "See",
    "intersection" => "See",
    "natural_feature" => "See",
    "neighborhood" => "See",
    "political" => "See",
    "point_of_interest" => "See",
    "post_box" => "See",
    "postal_code" => "See",
    "postal_code_prefix" => "See",
    "postal_code_suffix" => "See",
    "postal_town" => "See",
    "premise" => "See",
    "room" => "See",
    "route" => "See",
    "street_address" => "See",
    "street_number" => "See",
    "sublocality" => "See",
    "sublocality_level_4" => "See",
    "sublocality_level_5" => "See",
    "sublocality_level_3" => "See",
    "sublocality_level_2" => "See",
    "sublocality_level_1" => "See",
    "subpremise" => "See",
    "transit_station" => "See",
    "cemetery"=>"See",
    "city_hall"=>"See",
    "courthouse"=>"See",
    "embassy"=>"See",
    "establishment"=>"See",
    "fire_station"=>"See",
    "hindu_temple"=>"See",
    "mosque"=>"See",
    "parking"=>"See",
    "place_of_worship"=>"See",
    "police"=>"See",
    "school"=>"See",
    "stadium"=>"See",
    "subway_station"=>"See",
    "synagogue"=>"See",
    "train_station"=>"See",
    "university"=>"See",
    "accounting"=>"Shop",
    "atm"=>"Shop",
    "bank"=>"Shop",
    "bus_station"=>"See",
    "car_dealer"=>"Shop",
    "car_rental"=>"Shop",
    "car_repair"=>"Shop",
    "car_wash"=>"Shop",
    "dentist"=>"Shop",
    "doctor"=>"Shop",
    "electrician"=>"Shop",
    "finance"=>"Shop",
    "funeral_home"=>"Shop",
    "gas_station"=>"Shop",
    "general_contractor"=>"Shop",
    "hair_care"=>"Shop",
    "health"=>"Shop",
    "hospital"=>"Shop",
    "insurance_agency"=>"Shop",
    "laundry"=>"Shop",
    "lawyer"=>"Shop",
    "local_government_office"=>"Shop",
    "locksmith"=>"Shop",
    "movie_rental"=>"Shop",
    "moving_company"=>"Shop",
    "painter"=>"Shop",
    "physiotherapist"=>"Shop",
    "plumber"=>"Shop",
    "post_office"=>"Shop",
    "real_estate_agency"=>"Shop",
    "roofing_contractor"=>"Shop",
    "rv_park"=>"Shop",
    "storage"=>"Shop",
    "taxi_stand"=>"Shop",
    "travel_agency"=>"Shop",
    "veterinary_care"=>"Shop",
  }

  CATEGORIES_MAPPING = {
    "Eat" => ["bakery", "cafe", "meal_takeaway", "meal_delivery", "food", "restaurant"],
    "Sleep" => ["campground", "lodging"],
    "Drink" => ["liquor_store", "night_club", "bar"],
    "Shop" => ["beauty_salon", "bicycle_store", "book_store", "clothing_store", "convenience_store", "department_store", "electronics_store", "florist", "furniture_store", "grocery_or_supermarket", "hardware_store", "home_goods_store", "jewelry_store", "pet_store", "pharmacy", "shoe_store", "shopping_mall", "store", "accounting", "atm", "bank", "car_dealer", "car_rental", "car_repair", "car_wash", "dentist", "doctor", "electrician", "finance", "funeral_home", "gas_station", "general_contractor", "hair_care", "health", "hospital", "insurance_agency", "laundry", "lawyer", "local_government_office", "locksmith", "movie_rental", "moving_company", "painter", "physiotherapist", "plumber", "post_office", "real_estate_agency", "roofing_contractor", "rv_park", "storage", "taxi_stand", "travel_agency", "veterinary_care"],
    "See" => ["airport", "amusement_park", "aquarium", "art_gallery", "bowling_alley", "casino", "church", "gym", "library", "movie_theater", "museum", "park", "spa", "zoo", "locality", "natural_feature", "point_of_interest", "administrative_area_level_1", "administrative_area_level_2", "administrative_area_level_3", "administrative_area_level_4", "bus_station", "administrative_area_level_5", "colloquial_area", "country", "floor", "geocode", "intersection", "locality", "neighborhood", "political", "post_box", "postal_code", "postal_code_prefix", "postal_code_suffix", "postal_town", "premise", "room", "route", "street_address", "street_number", "sublocality", "sublocality_level_4", "sublocality_level_5", "sublocality_level_3", "sublocality_level_2", "sublocality_level_1", "subpremise", "transit_station", "cemetery", "city_hall", "courthouse", "embassy", "establishment", "fire_station", "hindu_temple", "mosque", "parking", "place_of_worship", "police", "school", "stadium", "subway_station", "synagogue", "train_station", "university"],
    "All" => ["airport", "amusement_park", "aquarium", "art_gallery", "bowling_alley", "casino", "church", "gym", "library", "movie_theater", "museum", "park", "spa", "zoo", "locality", "natural_feature", "point_of_interest", "beauty_salon", "bicycle_store", "book_store", "clothing_store", "convenience_store", "department_store", "electronics_store", "florist", "furniture_store", "grocery_or_supermarket", "hardware_store", "home_goods_store", "jewelry_store", "pet_store", "pharmacy", "shoe_store", "shopping_mall", "store", "liquor_store", "night_club", "bar", "campground", "lodging", "bakery", "cafe", "meal_takeaway", "meal_delivery", "food", "restaurant", "administrative_area_level_1", "administrative_area_level_2", "administrative_area_level_3", "administrative_area_level_4", "administrative_area_level_5", "colloquial_area", "country", "floor", "geocode", "intersection", "locality", "neighborhood", "political", "post_box", "postal_code", "postal_code_prefix", "postal_code_suffix", "postal_town", "premise", "room", "route", "street_address", "street_number", "sublocality", "sublocality_level_4", "sublocality_level_5", "sublocality_level_3", "sublocality_level_2", "sublocality_level_1", "subpremise", "transit_station", "cemetery", "city_hall", "courthouse", "embassy", "establishment", "fire_station", "hindu_temple", "mosque", "parking", "place_of_worship", "police", "school", "stadium", "subway_station", "synagogue", "train_station", "university", "accounting", "atm", "bank", "bus_station", "car_dealer", "car_rental", "car_repair", "car_wash", "dentist", "doctor", "electrician", "finance", "funeral_home", "gas_station", "general_contractor", "hair_care", "health", "hospital", "insurance_agency", "laundry", "lawyer", "local_government_office", "locksmith", "movie_rental", "moving_company", "painter", "physiotherapist", "plumber", "post_office", "real_estate_agency", "roofing_contractor", "rv_park", "storage", "taxi_stand", "travel_agency", "veterinary_care"]
  }

  belongs_to :guide
  has_one :user, through: :guide

  validates :name, presence: true

  def choosephoto
    if self.photo.url
      photo.url(:standard)
    elsif self.gphoto != ""
      gphoto
    else
      'logoholder_french.png'
    end
  end

  # def opened?(datetime=Time.current)
  #   return if opening_hours.empty?

  #   date = datetime.to_date
  #   day_hours = []

  #   if opening_hours.size == 14
  #     day = (date.wday * 2) - 2

  #     day_hours << opening_hours[day].split(': ').last
  #     day_hours << opening_hours[day + 1]
  #   else
  #     day = date.wday - 1
  #     day_hours << opening_hours[day].split(': ').last
  #   end

  #   return false if day_hours == ["Closed"]
  #   return false if day_hours == ["Fermé"]
  #   return true if day_hours == ["Ouvert 24h/24"]

  #   day_hours.each do |day_hour|
  #     hours = day_hour.strip.split(" – ")

  #     opening_hour, opening_minute = hours[0].split(':').map(&:to_i)
  #     opening_time = date.to_time.advance(hours: opening_hour, minutes: opening_minute)

  #     closing_hour, closing_minute = hours[1].split(':').map(&:to_i)
  #     closing_date = closing_hour < opening_hour ? date + 1.day : date
  #     closing_time = closing_date.to_time.advance(hours: closing_hour, minutes: closing_minute)

  #     return true if opening_time <= datetime && datetime <= closing_time
  #   end

  #   return false
  # end

end
