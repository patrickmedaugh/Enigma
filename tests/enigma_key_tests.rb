require 'minitest'
require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/enigma_key'

class EnigmaKeyTest < Minitest::Test

  def test_it_exists
    key = Key.new(41521)
    assert key
  end

  def test_it_has_rotations
    key = Key.new(41521)
    assert_equal 41, key.a_rotation
    assert_equal 15, key.b_rotation
    assert_equal 52, key.c_rotation
    assert_equal 21, key.d_rotation
  end

end
