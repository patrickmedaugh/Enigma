require_relative 'test_helper'
require_relative '../lib/enigma_brute_crack'
require 'pry'

class EnigmaCrackTest < Minitest::Test

  def test_it_exists
    crack = Brutecrack.new('../examples/crack_sample.txt', 30315)
    assert crack
  end

  def test_it_starts_at_key_attempt_00001
    crack = Brutecrack.new('../examples/crack_sample.txt', 30315)
    assert '00001', crack.key_attempt
  end

  def test_it_can_match_the_last_seven_chars
    brute = Brutecrack.new('../examples/crack_sample.txt', 31115)
    brute.normalize_text
    brute.key_attempt_iterator
    assert_equal brute.last_seven_chars, brute.end_statement
  end

  def test_it_can_reject_unwanted_chars
    brute = Brutecrack.new('../examples/crack_sample.txt', 31115)
    char_count_before = brute.text
    brute.normalize_text
    char_count_after = brute.text
    assert char_count_after < char_count_before
  end

end
