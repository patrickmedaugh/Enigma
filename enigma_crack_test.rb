require_relative 'test_helper'
require_relative '../lib/enigma_crack'

class EnigmaCrackTest < Minitest::Test

  def test_it_exists
    crack = Crack.new('sample.txt')
    assert crack
  end

  def test_it
  end

end
