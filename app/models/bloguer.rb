class Bloguer < ActiveRecord::Base

  mount_uploader :profile_pic, PhotoUploader
  mount_uploader :banner, PhotoUploader
  belongs_to :user


end
