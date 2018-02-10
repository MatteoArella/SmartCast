Given /^I am not authenticated$/ do
  #visit('/users/sign_out') # ensure that at least
  visit 'sign_out_path'
end