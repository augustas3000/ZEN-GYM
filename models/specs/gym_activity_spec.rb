require("minitest/autorun")
require('minitest/reporters')
Minitest::Reporters.use! Minitest::Reporters::SpecReporter.new

require_relative("../gym_activity.rb")

class TestActivity < MiniTest::Test

  def test_initialization

    options_hash = {
      'activity_name' => 'boxing'
    }

    activity_obj = Activity.new(options_hash)

    assert activity_obj != nil, "Expected something to not be nil"
  end
end
