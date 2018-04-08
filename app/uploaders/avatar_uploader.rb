class AvatarUploader < CarrierWave::Uploader::Base
	include CarrierWave::RMagick

	#storage :file

	def store_dir
		"uploads/#{model.class.base_class.to_s.underscore}/#{mounted_as}/#{model.id}"
	end

	def default_url
    'user-default.png' #rails will look at 'app/assets/images/default_avatar.png'
  end

	version :large do
		process resize_to_limit: [600, 600]
	end

	version :medium, :from_version => :large do
		process resize_to_limit: [300, 300]
	end

	version :small, :from_version => :medium do
		process resize_to_limit: [200, 200]
	end

	version :thumb do
		process :crop
		resize_to_fill(100, 100)
		def default_url
	    "thumb_user-default.png"
	  end
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

	def extension_whitelist
    %w(jpg jpeg gif png)
  end
end