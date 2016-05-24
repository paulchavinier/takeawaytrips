class Card < ActiveRecord::Base
  belongs_to :guide

  validates :name, presence: true
  validates :category, presence: true
  validates :formatted_address, presence: true
end
