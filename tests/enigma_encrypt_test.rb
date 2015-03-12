require_relative 'test_helper'
require_relative '../lib/enigma_encrypt'

class EnigmaEncryptTest < Minitest::Test

  def test_it_exists
    assert Encrypt
  end

  def test_it_has_a_char_map
    encrypt = Encrypt.new(nil,nil)
    assert_equal Array, encrypt.charmap.class
    assert " ", encrypt.charmap[-1]
    assert "a", encrypt.charmap[0]
  end

  def test_rotate_methods_return_a_char
    ep = Encrypt.new(nil,nil)
    assert_equal String, ep.rotate_a("b").class
  end

  def test_rotations_return_correct_char
    encrypt = Encrypt.new(41521, 20315)
    assert_equal "l", encrypt.rotate_a("a")
    assert_equal "r", encrypt.rotate_b("a")
    assert_equal "p", encrypt.rotate_c("a")
    assert_equal "0", encrypt.rotate_d("a")
  end

  def test_encrypt_parser_exists
    ep = EncryptParser.new('../examples/crack_sample.txt', 'Encrypted.txt')
    assert ep
  end

  def test_encrypt_parser_has_key_and_offset_params
    ep = EncryptParser.new('../examples/crack_sample.txt', 'Encrypted.txt')
    assert ep.key
    assert ep.offset
  end

  def test_encrypt_parser_can_read_lines
    ep = EncryptParser.new('../examples/crack_sample.txt', 'Encrypted.txt')
    assert_equal String, ep.text.class
  end

  def test_encrypt_parser_can_count_rotations
    en = Encrypt.new(nil,nil)
    en.rotate_counter
    assert_equal 1, en.rotate_count
    en.rotate_counter
    assert_equal 2, en.rotate_count
    2.times{en.rotate_counter}
    assert_equal 0, en.rotate_count
  end

  def test_encrypt_parser_can_translate_letters
    ep = EncryptParser.new('../examples/crack_sample.txt', 'Encrypted.txt')
    ep.normalize_text
    ep.encrypt.translate(ep.text)
    refute_equal ep.text[0], ep.encrypt.encrypted_chars[0]
    assert_equal String, ep.encrypt.encrypted_chars[0].class
    assert_equal String, ep.encrypt.encrypted_chars[0].class
  end

  def test_encrypt_parser_can_reject_invalid_characters
    ep = EncryptParser.new('../examples/crack_sample.txt', 'Encrypted.txt', 41521, 30315)
    chars_before = ep.text.length
    ep.normalize_text
    chars_after = ep.text.length
    assert chars_before > chars_after
  end

end
