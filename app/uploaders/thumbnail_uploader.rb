class ThumbnailUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick

  storage :fog
  process resize_to_fill: [250, 250]

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end
end
