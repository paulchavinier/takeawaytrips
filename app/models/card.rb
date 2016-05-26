class Card < ActiveRecord::Base

  mount_uploader :photo, PhotoUploader

  belongs_to :guide

  validates :name, presence: true
  validates :formatted_address, presence: true
end
