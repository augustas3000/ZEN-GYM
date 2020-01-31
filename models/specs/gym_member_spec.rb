require("minitest/autorun")
require('minitest/reporters')
Minitest::Reporters.use! Minitest::Reporters::SpecReporter.new

require_relative("../gym_member.rb")

class TestMember < MiniTest::Test

  def test_initialization
    options_hash = {
      'member_name' => 'Josh',
      'member_surname' => 'Smithers',
      'membership_status' => 'premium',
      'member_activation_status' => 'active'
    }

    member_obj = Member.new(options_hash)

    assert member_obj != nil, "Expected something to not be nil"
  end
end
