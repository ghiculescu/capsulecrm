require 'test_helper'
class PartyDotHistoryTest < Test::Unit::TestCase

  def setup
    VCR.use_cassette('person.find_by_id') do
      @person = CapsuleCRM::Person.find people(:pm)
    end
  end

  def test_load_history
    VCR.use_cassette('party.history') do
      assert_equal 2, @person.history.size
      assert_equal "First subject", @person.history[0].subject
    end
  end
  
  def test_add_history
    skip "Should write a cassette to handle adding a note"    
    VCR.use_cassette('party.history') do
      @person.add_history "new history"
      assert_equal 2, @person.history.size
    end
  end

  def teardown
    WebMock.reset!
  end

end
