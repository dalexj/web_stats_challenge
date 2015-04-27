require "test_helper"

class VisitTest < ActiveSupport::TestCase

  def visit
    @visit ||= Visit.new
  end

  def test_valid
    binding.pry
    assert visit.valid?
  end

end
