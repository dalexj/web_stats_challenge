class StatsController < ApplicationController
  def top_urls
    visits = Visit.all
    render json: visits_in_last_n_days(5)
  end

  def last_n_days(n)
    (1..n).map { |day| day.days.ago.to_date }
  end

  def visits_in_last_n_days(n)
    last_n_days(n).each_with_object({}) do |day, response|
      counts = Visit.counts_on_date(day)
      response[day.to_s] = counts unless counts.empty?
    end
  end
end
