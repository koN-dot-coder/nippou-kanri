require "test_helper"

class TeamTest < ActiveSupport::TestCase
  test "fixture is valid" do
    assert teams(:one).valid?
  end
end
