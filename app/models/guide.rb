class Guide < ActiveRecord::Base

  mount_uploader :photo, PhotoUploader
  extend FriendlyId
  friendly_id :name, use: :slugged

  belongs_to :user
  has_many :cards, dependent: :destroy

  validates :name, presence: true
  validates :place, presence: true
  validates :slug, presence: true
  geocoded_by :place
  after_validation :geocode, if: :place_changed?


  # reverse_geocoded_by :latitude, :longitude,
  #   :country => :location
  # after_validation :reverse_geocode


  def choosephoto
    if self.photo.url
      photo.url(:standard)
    else
      gphoto
    end
  end

  def guide_country
    latitude = self.latitude
    longitude = self.longitude
    geo_localization = "#{latitude},#{longitude}"
    country = Geocoder.search(geo_localization).first.country
  end

  def friendlist_filtered
    friends_table = self.user.friendslist
    friends_table_uid = []
    friends_table.each do |friend|
      if friend != nil
        friends_table_uid << friend.uid
      end
    end
    country_match = Guide.where(country: self.country)
    filtered_guides = []
    country_match.each do |guide|
      if friends_table_uid.include?(guide.user.uid)
        filtered_guides << guide
      end
    end

    filtered_users = []

    filtered_guides.each do |guide|
        unless filtered_users.include?(guide.user)
          filtered_users << guide.user
        end
    end
    # users.each do |user|
    #   if user != nil
    #     counter = 0
    #     user.guides.each do |guide|
    #         if guide.guide_country == self.guide_country  && counter == 0
    #           filtered_users << user
    #           counter += 1
    #         end
    #     end
    #   end
    # end
    filtered_users
  end

  # def distance(location)
  #   coordinates1 = Geocoder.coordinates(self.place)
  #   distancecalc = Geocoder::Calculations.distance_between(coordinates1, location)
  # end

  # def self.sorted_by_distance
  # Guide.all.sort_by(&:distance)
  # end

end
