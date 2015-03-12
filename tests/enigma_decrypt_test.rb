require_relative 'test_helper'
require_relative '../lib/enigma_decrypt'

class EnigmaDecryptTest < Minitest::Test

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

  def test_decrypt_parser_can_generate_key_and_offset_params_when_not_given
    de = DecryptParser.new('../examples/sample.txt')
    assert de.key
    assert de.offset
  end

  def test_decrypt_parser_can_read_lines
    de = DecryptParser.new('../examples/sample.txt')
    assert_equal String, de.text.class
  end

  def test_decrypt_parser_can_translate
    de = DecryptParser.new('../examples/sample.txt', 41251, 30315)
    de.normalize_text
    de.decrypt.translate(de.text)
    refute_equal de.text[3], de.decrypt.decrypted_chars[3]
    assert_equal String, de.decrypt.decrypted_chars[3].class
    assert_equal String, de.text[3].class
  end

  def test_decrypt_parser_can_reject_invalid_chars
    text = "nazi stuff woooooooo ...end.."
    de = DecryptParser.new('../examples/sample.txt')
    assert_equal text, de.normalize_text
  end

end
