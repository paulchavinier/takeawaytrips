class PhotoUploader < CarrierWave::Uploader::Base
  include Cloudinary::CarrierWave
  process eager: true  # Force version generation at upload time.

  process convert: 'jpg'
  version :standard do
    cloudinary_transformation width: 700, crop: :scale, quality: :auto
  end
end
