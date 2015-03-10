require_relative 'test_helper'
require_relative '../lib/enigma_brute_crack'

class EnigmaCrackTest < Minitest::Test

  def test_it_exists
    crack = Brutecrack.new('sample.txt', 30315)
    assert crack
  end

  def test_it_starts_at_key_attempt_00001
    crack = Brutecrack.new('sample.txt', 30315)
    assert '00001', crack.key_s
  end

end
