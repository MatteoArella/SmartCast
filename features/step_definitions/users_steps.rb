Given /^I am not authenticated$/ do
  #visit('/users/sign_out') # ensure that at least
  page.driver.submit :delete, sign_out_path, {}
end

Given /^I am a registered and confirmed user$/ do
	#username = 'dummyUsername'
	#email = 'testing@man.net'
  #password = 'secretpass'
  #role = 'artist'
  #User.new(:username => username, :email => email, :password => password, :password_confirmation => password, :role => role, :confirmed_at => DateTime.now).save!
  create(:user)
end

When /^I sign in with valid email and password$/ do
	email = 'testing@man.net'
  password = 'secretpass'
	fill_in "user[login]", :with => email
  fill_in "user_password", :with => password
  click_button "Sign in"
end

When /^I sign in with valid username and password$/ do
	username = 'dummyUsername'
  password = 'secretpass'
	fill_in "user[login]", :with => username
  fill_in "user_password", :with => password
  click_button "Sign in"
end

When /^I sign in with invalid credentials$/ do
	username = 'wrongUsername'
  password = 'secretpass'
	fill_in "user[login]", :with => username
  fill_in "user_password", :with => password
  click_button "Sign in"
end

Then /^I should see a success message$/ do
  text = "confirmation"
  if page.respond_to? :should
    page.should have_content(text)
  else
    assert page.has_content?(text)
  end
end

Then /^I should see an error message$/ do
	text = "Invalid"
	if page.respond_to? :should
    page.should have_content(text)
  else
    assert page.has_content?(text)
  end
end