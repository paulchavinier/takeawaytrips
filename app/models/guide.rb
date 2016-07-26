class Guide < ActiveRecord::Base

  mount_uploader :photo, PhotoUploader

  belongs_to :user
  has_many :cards, dependent: :destroy

  validates :name, presence: true
  validates :place, presence: true
  geocoded_by :place
  after_validation :geocode, if: :place_changed?

  # reverse_geocoded_by :latitude, :longitude,
  #   :country => :location
  # after_validation :reverse_geocode


  def choosephoto
    if self.photo.url
      photo
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
    friends = self.user.get_friendslist
    users = []
    while friends != nil
      friends.each do |friend|
        users << User.find_by(uid: friend["id"])
      end
      friends = friends.next_page
    end
    raise
    filtered_users = []
    users.each do |user|
      if user != nil
        counter = 0
        user.guides.each do |guide|
            if guide.guide_country == self.guide_country  && counter == 0
              filtered_users << user
              counter += 1
            end
        end
      end
    end
    filtered_users
  end

end
