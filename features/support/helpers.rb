module Helpers

  def get_date(date_name)
    case date_name
    when "today"
      Date.today
    when "tomorrow"
      Date.tomorrow
    when "yesterday"
      Date.yesterday
    end
  end
end

World(Helpers)
