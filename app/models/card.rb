class Card < ActiveRecord::Base
  belongs_to :guide, dependent: :destroy

  validates :name, presence: true
  validates :category, presence: true
  validates :formatted_address, presence: true
end
