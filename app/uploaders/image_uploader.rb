class ImageUploader < CarrierWave::Uploader::Base
	include CarrierWave::MiniMagick

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

	version :medium, :from_version => :large do
		process resize_to_limit: [300, 150]
	end

	version :thumb do
		process :crop
		resize_to_fill(100, 100)
	end

	version :square do
		process resize_to_fill: [500, 500]
	end

	version :banner_image do
		process resize_to_limit: [1200, 800]
	end

	def crop
	  if model.crop_x.present?
	    resize_to_limit(600, 600)
	    manipulate! do |img|
	      x = model.crop_x.to_i
	      y = model.crop_y.to_i
	      w = model.crop_w.to_i
	      h = model.crop_h.to_i
	      img.crop!(x, y, w, h)
	    end
	  end
	end

	def extension_white_list
    %w(jpg jpeg gif png)
  end
end