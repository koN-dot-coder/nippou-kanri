require "test_helper"

class UserTest < ActiveSupport::TestCase
  test "fixture is valid" do
    assert users(:boss).valid?
    assert users(:member).valid?
  end
end
