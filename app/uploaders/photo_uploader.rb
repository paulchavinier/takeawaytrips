class PhotoUploader < CarrierWave::Uploader::Base
  include Cloudinary::CarrierWave # les upload d image sont gérés par le service Cloudinary
  process eager: true  # Force version generation at upload time. Quand tu upload l image fait des transformation en avance

  process convert: 'jpg'
  version :standard do
    resize_to_fit 600, 450
  end
end
