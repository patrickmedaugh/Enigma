require_relative 'enigma_offsets'
require_relative 'enigma_encrypt'


class Crack

  def initialize(file)
    handle = File.open(file)
    @last7 = handle.readlines(file).join.strip
    @last7 = @last7.to_s.reverse[0..6].reverse
  end

  def backmap
    expected = ['.','.','e','n','d','.','.']
    encrypt  = Encrypt.new(50403)
    charmap  = encrypt.charmap
    i=0
    @last7.each do |letter|
      letter_position = charmap.find_index(letter)
      new_position = letter_position - (encrypt.rot2 + expected[i])
      i += 1
    end
  end
end


# crack = Crack.new('crack_sample.txt')
# puts crack.backmap
