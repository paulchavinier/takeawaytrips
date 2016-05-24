class Card < ActiveRecord::Base
  belongs_to :guide

  validates :name, presence: true
  validates :type, presence: true
  validates :formatted_address, presence: true

end
