class Guide < ActiveRecord::Base
  belongs_to :user
  has_many :cards, dependent: :destroy

  validates :name, presence: true
  geocoded_by :place
  after_validation :geocode, if: :place_changed?
end
