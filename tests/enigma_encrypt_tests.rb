require 'minitest'
require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/enigma_encrypt'

class EnigmaEncryptTest < Minitest::Test

  def test_it_exists
    encrypt = Encrypt.new(nil)
    assert encrypt
  end

  def test_it_has_a_char_map
    encrypt = Encrypt.new(nil)
    assert_equal Array, encrypt.charmap.class
    assert " ", encrypt.charmap[-1]
    assert "a", encrypt.charmap[0]
  end

  def test_rotate_methods_return_a_char
    encrypt = Encrypt.new(50403, 30315)
    assert_equal String, encrypt.rotate_a("b").class
  end

  def test_rotations_return_correct_char
    encrypt = Encrypt.new(50403, 30315)
    assert_equal "u", encrypt.rotate_a("a")
    assert_equal "g", encrypt.rotate_b("a")
    assert_equal "d", encrypt.rotate_c("a")
    assert_equal "i", encrypt.rotate_d("a")
  end

  def test_input_parser_exists
    input = InputParser.new('sample.txt')
    assert input
  end

  def test_input_parser_can_read_lines
    input = InputParser.new('sample.txt')
    refute_equal nil, input.lines.class
    assert_equal String, input.lines.class
  end

  def test_input_parser_can_count_rotations
    input = InputParser.new('sample.txt')
    input.rotate_counter
    assert_equal 1, input.rot_count
    input.rotate_counter
    assert_equal 2, input.rot_count
    2.times{input.rotate_counter}
    assert_equal 0, input.rot_count
  end

end
