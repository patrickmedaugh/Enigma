require 'simplecov'
SimpleCov.start
require 'minitest'
require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/enigma_encrypt'

class EnigmaEncryptTest < Minitest::Test

  def test_it_exists
    ep = EncryptParser.new('sample.txt')
    ep.translate
    assert ep.encrypt
  end

  def test_it_has_a_char_map
    ep = EncryptParser.new('sample.txt', 41295, 30315)
    ep.translate
    encrypt = ep.encrypt
    assert_equal Array, encrypt.charmap.class
    assert " ", encrypt.charmap[-1]
    assert "a", encrypt.charmap[0]
  end

  def test_rotate_methods_return_a_char
    ep = EncryptParser.new('sample.txt')
    ep.translate
    assert_equal String, ep.encrypt.rotate_a("b").class
  end

  def test_rotations_return_correct_char
    encrypt = Encrypt.new(50403, 30315)
    assert_equal "u", encrypt.rotate_a("a")
    assert_equal "g", encrypt.rotate_b("a")
    assert_equal "d", encrypt.rotate_c("a")
    assert_equal "i", encrypt.rotate_d("a")
  end

  def test_encrypt_parser_exists
    ep = EncryptParser.new('sample.txt')
    assert ep
  end

  def test_encrypt_parser_has_key_and_offset_params
    ep = EncryptParser.new('sample.txt')
    assert ep.key
    assert ep.offset
  end

  def test_encrypt_parser_can_read_lines
    ep = EncryptParser.new('sample.txt')
    refute_equal nil, ep.lines.class
    assert_equal String, ep.lines.class
  end

  def test_encrypt_parser_can_count_rotations
    ep = EncryptParser.new('sample.txt')
    ep.rotate_counter
    assert_equal 1, ep.rot_count
    ep.rotate_counter
    assert_equal 2, ep.rot_count
    2.times{ep.rotate_counter}
    assert_equal 0, ep.rot_count
  end

  def test_encrypt_parser_can_translate_letters
    ep = EncryptParser.new('sample.txt')
    ep.translate
    refute_equal ep.lines[0], ep.new_lines[0]
    assert_equal String, ep.new_lines[0].class
    assert_equal String, ep.lines[0].class
  end

  def test_encrypt_parser_translates_to_correct_letter
    ep = EncryptParser.new('sample.txt', 41521, 30315)
    ep.translate
    assert_equal ep.new_lines[0], "l"
    assert_equal ep.new_lines[1], "s"
    assert_equal ep.new_lines[2], "r"
    assert_equal ep.new_lines[3], "3"
  end

end
