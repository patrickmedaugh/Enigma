require_relative 'enigma_key'
require_relative 'enigma_offsets'


class Encrypt

  attr_reader :charmap, :rot1, :rot2

  def initialize(key, offset = CurrentDate.new)
    @rot1 = Key.new(key)
    @rot2 = Offset.new(offset)
    @charmap = [*('a'..'z'), *(0..9), " ", ".", "," ]
  end

  def rotate_a(char)
    position = @charmap.find_index(char)
    char = @charmap[(position + @rot1.a_rotation + @rot2.a) % 39]
  end

  def rotate_b(char)
    position = @charmap.find_index(char)
    char = @charmap[(position + @rot1.b_rotation + @rot2.b) % 39]
  end

  def rotate_c(char)
    position = @charmap.find_index(char)
    char = @charmap[(position + @rot1.c_rotation + @rot2.c) % 39]
  end

  def rotate_d(char)
    position = @charmap.find_index(char)
    char = @charmap[(position + @rot1.d_rotation + @rot2.d) % 39]
  end

end

class InputParser

  attr_reader :lines, :rot_count

  def initialize(file)
    handle = File.open(file)
    @lines = handle.readlines(file)
    @lines = @lines.join
    @rot_count = 0
  end

  def rotate
      case @rot_count
      when 0
        @rot_count += 1
      when 1
        @rot_count += 1
      when 2
        @rot_count += 1
      when 3
        @rot_count  = 0
      end
  end
  #grab four characters from lines
  #run encryption on it (rotations a..d)
  #pass to writer

end
