require_relative 'test_helper'
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

  def test_each_offset_has_an_integer
    off = Offset.new(30315)
    assert_equal 9, off.a
    assert_equal 2, off.b
    assert_equal 2, off.c
    assert_equal 5, off.d
  end

  def test_offset_can_generate_based_on_date
    off = Offset.new
    assert_equal Fixnum, off.date.class
    assert_equal String, off.num.class
  end
end
