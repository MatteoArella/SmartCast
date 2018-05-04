When /^I fill (videopodcast|audiopodcast) form with valid data$/ do | type |
	fill_in "podcast_name", :with => "Podcast Title"
	fill_in "podcast_description", :with => "Podcast Description"
	attach_file("podcast_image", "features/uploads/image.jpg")
	
	case type

	when "videopodcast"
		find("input[value='#{VideoPodcast}']").click
	when "audiopodcast"
		find("input[value='#{AudioPodcast}']").click
	end
end

When /^I fill (videopodcast|audiopodcast) form with "([^"]*)", "([^"]*)", "([^"]*)"$/ do | type, name, description, image |

	fill_in "podcast_name", :with => name
	fill_in "podcast_description", :with => description
	attach_file("podcast_image", "features/uploads/#{image}") unless image.blank?
	
	case type

	when "videopodcast"
		find("input[value='#{VideoPodcast}']").click
	when "audiopodcast"
		find("input[value='#{AudioPodcast}']").click
	end
end