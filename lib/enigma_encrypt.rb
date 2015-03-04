require_relative 'enigma_key'
require_relative 'enigma_offsets'


class Encrypt

  attr_reader :charmap, :rot1, :rot2

  def initialize(key, offset = CurrentDate.new)
    @rot1 = Key.new(key)
    @rot2 = Offset.new
    @charmap = [*('a'..'z'), *(0..9), " ", ".", "," ]
  end

  def rotate_a
    @rot1.a_rotation + @rot2.a
  end

  def rotate_b
    @rot1.b_rotation + @rot2.b
  end

  def rotate_c
    @rot1.c_rotation + @rot2.c
  end

  def rotate_d
    @rot1.d_rotation + @rot2.d
  end

end

class InputParser

  attr_reader :handle, :lines

  def initialize(file)
    handle = File.open(file)
    @lines = handle.readlines(file)
  end

  #grab four characters from lines
  #run encryption on it (rotations a..d)
  #pass to writer

end
