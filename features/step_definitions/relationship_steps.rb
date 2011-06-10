Given /^I am following the user "([^"]*)"$/ do |followed_user|
  visit path_to("#{followed_user}'s follow page")
end

Given /^I am not following the user "([^"]*)"$/ do |unfollowed_user|
  visit path_to("#{unfollowed_user}'s unfollow page")
end
