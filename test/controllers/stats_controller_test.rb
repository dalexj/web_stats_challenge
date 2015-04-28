require "test_helper"

class StatsControllerTest < ActionController::TestCase
  # number of page views per URL, grouped by day, for the past 5 days;
  def test_top_urls_groups_by_date_sorted_by_visit_amount
    Visit.create(url: "https://example.com/2", created_at: 1.day.ago)
    Visit.create(url: "https://example.com/2", created_at: 1.day.ago)
    Visit.create(url: "https://example.com/1", created_at: 1.day.ago)
    Visit.create(url: "https://example.com/", created_at: 2.days.ago)
    Visit.create(url: "https://example.com/", created_at: 40.days.ago)
    get :top_urls
    visits = JSON.parse(response.body)
    expected = {
      json_date(1) => [ { "url" => "https://example.com/2", "visits" => 2 },
                           { "url" => "https://example.com/1", "visits" => 1 } ],
      json_date(2) => [ { "url" => "https://example.com/", "visits" => 1 } ],
    }

    assert_equal expected, visits
  end

  def test_only_gets_last_5_days
    Visit.create(url: "https://example.com/", created_at: 1.days.ago)
    Visit.create(url: "https://example.com/", created_at: 2.days.ago)
    Visit.create(url: "https://example.com/", created_at: 3.days.ago)
    Visit.create(url: "https://example.com/", created_at: 4.days.ago)
    Visit.create(url: "https://example.com/", created_at: 5.days.ago)
    Visit.create(url: "https://example.com/", created_at: 6.days.ago)
    get :top_urls
    visits = JSON.parse(response.body)
    expected = {
      json_date(1) => [ { "url" => "https://example.com/", "visits" => 1 } ],
      json_date(2) => [ { "url" => "https://example.com/", "visits" => 1 } ],
      json_date(3) => [ { "url" => "https://example.com/", "visits" => 1 } ],
      json_date(4) => [ { "url" => "https://example.com/", "visits" => 1 } ],
      json_date(5) => [ { "url" => "https://example.com/", "visits" => 1 } ],
    }

    assert_equal expected, visits
  end

  def json_date(days_ago)
    days_ago.days.ago.to_date.to_s
  end
end
