class Guide < ActiveRecord::Base

  mount_uploader :photo, PhotoUploader

  belongs_to :user
  has_many :cards, dependent: :destroy

  validates :name, presence: true
  validates :place, presence: true
  geocoded_by :place
  after_validation :geocode, if: :place_changed?
end
