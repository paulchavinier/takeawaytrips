class Guide < ActiveRecord::Base

  mount_uploader :photo, PhotoUploader

  belongs_to :user
  has_many :cards

  validates :name, presence: true
  geocoded_by :place
  after_validation :geocode, if: :place_changed?
end
