require_relative 'test_helper'
require_relative '../lib/enigma_brute_crack'

class EnigmaCrackTest < Minitest::Test

  def test_it_exists
    crack = Brutecrack.new('../examples/crack_sample.txt', 30315)
    assert crack
  end

  def test_it_starts_at_key_attempt_00001
    crack = Brutecrack.new('../examples/crack_sample.txt', 30315)
    assert '00001', crack.key_s
  end

  def test_it_can_match_the_last_seven_chars
    brute = Brutecrack.new('../examples/crack_sample.txt', 31115)
    brute.key_attempt = '00001'
    brute.key_attempt_iterator
    assert_equal brute.last_seven_chars, brute.end_statement
  end


end
