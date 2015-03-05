require 'simplecov'
SimpleCov.start
require 'minitest'
require 'minitest/autorun'
require 'minitest/pride'
require_relative "../lib/enigma_offsets.rb"

class EnigmaOffsetsTest < Minitest::Test

  def test_it_exists
    offset = Offset.new
    assert offset
  end

  def test_current_date_object_returns_an_integer
    current = CurrentDate.new
    assert Integer, current.class
  end

  def test_it_can_return_the_last_four_of_the_date
    offset = Offset.new(30315)
    assert_equal "9225", offset.num
  end

  def test_each_offset_has_an_integer
    off = Offset.new(30315)
    assert_equal 9, off.a
    assert_equal 2, off.b
    assert_equal 2, off.c
    assert_equal 5, off.d
  end

end
