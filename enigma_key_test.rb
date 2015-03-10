require_relative 'test_helper'
require_relative '../lib/enigma_key'

class EnigmaKeyTest < Minitest::Test

  def test_it_exists
    key = Key.new(41521)
    assert key
  end

  def test_it_has_rotations
    key = Key.new(41521)
    assert_equal 41, key.a
    assert_equal 15, key.b
    assert_equal 52, key.c
    assert_equal 21, key.d
  end

end
