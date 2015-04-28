require "test_helper"

class StatsControllerTest < ActionController::TestCase
  # number of page views per URL, grouped by day, for the past 5 days;
  def test_top_urls_groups_by_date
    Visit.create(url: "https://example.com/", created_at: Date.parse("04-27-2015"))
    Visit.create(url: "https://example.com/", created_at: Date.parse("04-27-2015"))
    Visit.create(url: "https://example.com/", created_at: Date.parse("04-26-2015"))
    Visit.create(url: "https://example.com/", created_at: Date.parse("04-11-2015"))
    get :top_urls
    visits = JSON.parse(response.body)
    expected = {
      "04-27-2015" => [ { "url" => "https://example.com/", "visits" => 2 } ],
      "04-26-2015" => [ { "url" => "https://example.com/", "visits" => 1 } ],
    }

    assert_equal expected, visits
  end
end
