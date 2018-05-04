When /^I fill (videopodcast|audiopodcast) form with valid data$/ do | type |
	@podcast = create(type.to_sym)

	fill_in "podcast_name", :with => @podcast.name
	fill_in "podcast_description", :with => @podcast.description
	attach_file("podcast_image", "/home/biar/Documents/Progetto/SmartCast/features/uploads/image.jpg")
	find("input[value='#{@podcast.type}']").click
end