class StatsController < ApplicationController
  def top_urls
    render json: visits_in_last_n_days(5)
  end

  def top_referrers
    render json: top_urls_last_n_days(5, 10)
  end

  private

  def top_urls_last_n_days(n, url_limit)
    visits_in_last_n_days(n, url_limit).each do |date, urls|
      urls.each do |url|
        url[:referrers] = Visit.referrers_for_url_on_date(url[:url], date)
      end
    end
  end

  def last_n_days(n)
    (1..n).map { |day| day.days.ago.to_date }
  end

  def visits_in_last_n_days(n, limit = nil)
    last_n_days(n).each_with_object({}) do |day, response|
      counts = Visit.counts_on_date(day, limit)
      response[day.to_s] = counts unless counts.empty?
    end
  end
end
