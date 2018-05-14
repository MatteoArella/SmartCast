When /^I fill (videopodcast|audiopodcast) form with valid data$/ do | type |
	fill_in "podcast_title", :with => "Podcast Title"
	fill_in "podcast_description", :with => "Podcast Description"
	attach_file("podcast_image", "features/uploads/image.jpg")
	
	case type

	when "videopodcast"
		find("input[value='#{VideoPodcast}']").click
	when "audiopodcast"
		find("input[value='#{AudioPodcast}']").click
	end
end

When /^I fill form with "([^"]*)", "([^"]*)", "([^"]*)"$/ do | title, description, image |

	fill_in "podcast_title", :with => title
	fill_in "podcast_description", :with => description
	attach_file("podcast_image", "features/uploads/#{image}") unless image.blank?
	
	find("input[value='#{VideoPodcast}']").click
end

And /^a podcast exists$/ do
	@podcast = create(:podcast, :artist_id => @artist.id)
end
