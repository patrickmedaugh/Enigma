require_relatie 'test_helper'
require_relative '../lib/enigma_decrypt'

class EnigmaDecryptTest < Minitest::Test

  def test_it_exists
    decrypt = Decrypt.new(50403, 30315)
    assert decrypt
  end

  def test_it_has_a_char_map
    decrypt = Decrypt.new(50403, 30315)
    assert_equal Array, decrypt.charmap.class
    assert " ", decrypt.charmap[-1]
    assert "a", decrypt.charmap[0]
  end

  def test_rotate_methods_return_a_char
    decrypt = Decrypt.new(50403, 30315)
    assert_equal String, decrypt.rotate_a("b").class
  end

  def test_rotations_return_correct_char
    decrypt = Decrypt.new(50403, 30315)
    assert_equal "a", decrypt.rotate_a("u")
    assert_equal "a", decrypt.rotate_b("g")
    assert_equal "a", decrypt.rotate_c("d")
    assert_equal "a", decrypt.rotate_d("i")
  end

  def test_rotations_can_wrap_around_array
    decrypt = Decrypt.new(41521, 30315)
    assert_equal decrypt.charmap[-11], decrypt.rotate_a("a")
  end

  def test_decrypt_parser_exists
    de = DecryptParser.new('sample.txt')
    assert de
  end

  def test_decrypt_parser_has_key_and_offset_params
    de = DecryptParser.new('sample.txt')
    assert de.key
    assert de.offset
  end

  def test_decrypt_parser_can_read_lines
    de = DecryptParser.new('sample.txt')
    assert_equal String, de.lines.class
  end

  def test_decrypt_parser_can_translate
    de = DecryptParser.new('sample.txt')
    de.validate_text
    de.translate
    refute_equal de.lines[0], de.new_lines[0]
    assert_equal String, de.new_lines[0].class
    assert_equal String, de.lines[0].class
  end

  def test_decrypt_parser_can_reject_invalid_chars
    de = DecryptParser.new('sample.txt')
    assert_equal 'abcde', de.validate_text
  end

end
