require 'minitest'
require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/enigma_decrypt'

class EnigmaDecryptTest < Minitest::Test

  def test_it_exists
    decrypt = Decrypt.new(nil)
    assert decrypt
  end

  def test_it_has_a_char_map
    decrypt = Decrypt.new(nil)
    assert_equal Array, decrypt.charmap.class
    assert " ", decrypt.charmap[-1]
    assert "a", decrypt.charmap[0]
  end

  def test_rotate_methods_return_a_char
    decrypt = Decrypt.new(50403, 30315)
    assert_equal String, decrypt.rotate_a("b").class
  end
  #maybe change these up so they don't mirro the encryptor tests
  def test_rotations_return_correct_char
    decrypt = Decrypt.new(50403, 30315)
    assert_equal "a", decrypt.rotate_a("u")
    assert_equal "a", decrypt.rotate_b("g")
    assert_equal "a", decrypt.rotate_c("d")
    assert_equal "a", decrypt.rotate_d("i")
  end

end
