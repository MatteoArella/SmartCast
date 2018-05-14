Given /^I am not authenticated$/ do
  page.driver.submit :delete, sign_out_path, {}
end

Given /^I am a registered and confirmed user$/ do
	@user = create(:user)
end

When /^I sign in with valid email and password$/ do
	fill_in "user[login]", :with => @user.email
  fill_in "user_password", :with => @user.password
  click_button "Sign In"
end

Given /^the following users exists:$/ do |fields|
  fields.hashes.each do | hash_row |
    hash_row.each do | key, value |
      if key.eql? "email"
        @email = value
      elsif key.eql? "password"
        @password = value
      elsif key.eql? "type"
        @type = value
      end
    end

    case @type
      when "admin"
        @admin = create(:admin, :email => @email, :password => @password)
      when "artist"
        @artist = create(:artist, :email => @email, :password => @password)
      when "learner"
        @learner = create(:learner, :email => @email, :password => @password)
    end
  end
end

Given /^I am signed in as an? (artist|learner|admin) user$/ do |role|
  @user = create(role.to_sym)
  step "I am on the Sign In page"
  step "I sign in with valid email and password"
end

Given /^I am signed in with (.*) email and (.*) password$/ do | email, password |
  step "I am on the Sign In page"
  steps %Q{
    When I fill in "user[login]" with #{email}
    When I fill in "user_password" with #{password}
  }
end

When /^I sign in with valid username and password$/ do
	fill_in "user[login]", :with => @user.username
  fill_in "user_password", :with => @user.password
  click_button "Sign In"
end

When /^I sign in with invalid credentials$/ do
	fill_in "user[login]", :with => @user.username
  fill_in "user_password", :with => "wrongPassword"
  click_button "Sign In"
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