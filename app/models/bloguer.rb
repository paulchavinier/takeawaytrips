class Bloguer < ActiveRecord::Base

  mount_uploader :profile_pic, PhotoUploader
  mount_uploader :banner, PhotoUploader
  mount_uploader :facebook_pic, PhotoUploader

  extend FriendlyId
  friendly_id :name, use: :slugged

  belongs_to :user
  validates :slug, presence: true

end
