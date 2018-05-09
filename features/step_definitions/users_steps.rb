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

Given /^I am signed in as an? (artist|learner|admin) user$/ do |role|
  @user = create(role.to_sym)
  step "I am on the Sign In page"
  step "I sign in with valid email and password"
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