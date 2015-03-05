
require 'minitest'
require 'minitest/autorun'
require 'minitest/pride'
require '../lib/enigma_crack'

class EnigmaCrackTest < Minitest::Test

  def test_it_exists
    crack = Crack.new('sample.txt')
    assert crack
  end

  def test_it
  end
  
end
