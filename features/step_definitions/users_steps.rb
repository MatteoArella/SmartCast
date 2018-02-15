Given /^I am not authenticated$/ do
  #visit('/users/sign_out') # ensure that at least
  page.driver.submit :delete, sign_out_path, {}
end