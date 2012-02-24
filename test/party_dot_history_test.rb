require 'test_helper'
class PartyDotHistoryTest < Test::Unit::TestCase

  def setup
    VCR.use_cassette('person.find_by_id') do
      @person = CapsuleCRM::Person.find people(:pm)
    end
  end

  def test_load_history
    VCR.use_cassette('party.history') do
      @history = @person.history
    end
    assert_equal 2, @history.size
    assert_equal "First subject", @history[0].subject
  end
  
  def test_add_history
    VCR.use_cassette('party.history') do
      @history = @person.history
    end
    assert_equal 2, @history.size
    assert_equal "First subject", @history[0].subject
  end

  def teardown
    WebMock.reset!
  end

end
