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

  def test_rotate_methods_return_a_fixnum
    encrypt = Encrypt.new(50403, 303015)
    assert_equal Fixnum, encrypt.rotate_a.class
  end

  def test_rotations_return_correct_number
    encrypt = Encrypt.new(50403, 303015)
    assert_equal 59, encrypt.rotate_a
    assert_equal 6, encrypt.rotate_b
    assert_equal 42, encrypt.rotate_c
    assert_equal 8, encrypt.rotate_d
  end

  def test_input_parser_exists
    input = InputParser.new('sample.txt')
    assert input
  end

  def test_input_parser_can_read_lines
    input = InputParser.new('sample.txt')
    assert_equal Array, input.lines.class
    puts input.lines
  end

end
