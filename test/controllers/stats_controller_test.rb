require "test_helper"

class StatsControllerTest < ActionController::TestCase
  # number of page views per URL, grouped by day, for the past 5 days;
  def test_top_urls_groups_by_date
    Visit.create(url: "https://example.com/2", created_at: Date.parse("2015-04-27"))
    Visit.create(url: "https://example.com/2", created_at: Date.parse("2015-04-27"))
    Visit.create(url: "https://example.com/1", created_at: Date.parse("2015-04-27"))
    Visit.create(url: "https://example.com/", created_at: Date.parse("2015-04-26"))
    Visit.create(url: "https://example.com/", created_at: Date.parse("2015-04-11"))
    get :top_urls
    visits = JSON.parse(response.body)
    expected = {
      "2015-04-27" => [ { "url" => "https://example.com/2", "visits" => 2 },
                        { "url" => "https://example.com/1", "visits" => 1 } ],
      "2015-04-26" => [ { "url" => "https://example.com/", "visits" => 1 } ],
    }

    assert_equal expected, visits
  end
end
