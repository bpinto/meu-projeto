module NavigationHelpers
  # Maps a name to a path. Used by the
  #
  #   When /^I go to (.+)$/ do |page_name|
  #
  # step definition in web_steps.rb
  #
  def path_to(page_name)
    case page_name

    when /the home\s?page/
      '/'

    when /the sign up page/
      '/users/sign_up'

    when /the sign in page/
      '/users/sign_in'

    when /^the new deal page/i
      new_deal_path($1)

    when /today's deals page/
      deals_today_path

    when /deal "([^"]*)"'s page/i
      deal_path(Deal.find_by_title($1))

    when /^(.*)'s page/i
      user_path($1)

    when /^(.*)'s edit page/i
      edit_user_registration_path

    when /^(.*)'s follow page/i
      follow_user_path($1)

    when /^(.*)'s unfollow page/i
      unfollow_user_path($1)

    # Add more mappings here.
    # Here is an example that pulls values out of the Regexp:
    #
    #   when /^(.*)'s profile page$/i
    #     user_profile_path(User.find_by_login($1))

    else
      begin
        page_name =~ /the (.*) page/
        path_components = $1.split(/\s+/)
        self.send(path_components.push('path').join('_').to_sym)
      rescue Object => e
        raise "Can't find mapping from \"#{page_name}\" to a path.\n" +
          "Now, go and add a mapping in #{__FILE__}"
      end
    end
  end
end

World(NavigationHelpers)
