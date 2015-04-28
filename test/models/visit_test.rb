require "test_helper"

class VisitTest < ActiveSupport::TestCase

  def valid_url
    "http://apple.com"
  end

  def valid_created_at
    Date.today
  end

  def test_valid_only_with_url_and_created_at
    visit = Visit.new(url: valid_url, created_at: valid_created_at)
    assert visit.valid?

    visit.url = nil
    refute visit.valid?

    visit.url = valid_url
    visit.created_at = nil
    refute visit.valid?
  end

  def test_creates_a_hash_on_create
    visit = Visit.new(url: valid_url, created_at: valid_created_at)
    refute visit.digested_hash

    visit.save
    assert visit.digested_hash
  end

  def test_converts_created_at_to_date_on_save
    visit = Visit.new(url: valid_url, created_at: Time.parse("2015-04-28 12:12:12 -0600"))
    visit.save
    assert_equal Time.parse("2015-04-28 00:00:00 -0600"), visit.created_at
  end

end
