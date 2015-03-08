require_relative 'enigma_offsets'
require_relative 'enigma_encrypt'


class Crack

  attr_reader :last7, :position

  def initialize(file)
    handle    = File.open(file)
    @last7    = handle.readlines(file).join.strip
    @last7    = @last7.to_s.reverse[0..6].reverse.split("")
    @position = []
    @rot_count= 0
  end

  def backmap
    expected = [37,37, 4, 13, 3, 37, 37]
    encrypt  = Encrypt.new(41521, 30315)
    charmap  = encrypt.charmap
    i=0
    @last7.each do |letter|
      @position << charmap.find_index(letter) - encrypt.rot2.a
    end
  end

end
