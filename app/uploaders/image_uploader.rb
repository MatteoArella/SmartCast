class ImageUploader < CarrierWave::Uploader::Base
	include CarrierWave::RMagick

	#storage :file

	def store_dir
		"uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
	end

	#def default_url
  #  'default_avatar.png' #rails will look at 'app/assets/images/default_avatar.png'
  #end

	version :large do
		process resize_to_limit: [600, 600]
	end

	version :medium do
		process resize_to_limit: [400, 300]
	end

	version :thumb do
		process resize_to_fill: [100, 100]
	end

	version :square do
		process resize_to_fill: [500, 500]
	end

	version :banner_image do
		process resize_to_limit: [1200, 800]
	end

	def extension_white_list
    %w(jpg jpeg gif png)
  end
end