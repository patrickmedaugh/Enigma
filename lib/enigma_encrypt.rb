require_relative 'enigma_key'
require_relative 'enigma_offsets'


class Encrypt

  attr_reader :charmap, :rot1, :rot2

  def initialize(key, offset = CurrentDate.new)
    @rot1 = Key.new(key)
    @rot2 = Offset.new(offset)
    @charmap = [*("a".."z"), *("0".."9"), " ", ".", "," ]
  end

  def rotate_a(char)
    position = @charmap.find_index(char)
    rotate = position + @rot1.a + @rot2.a
    char = @charmap[rotate % 39]
  end

  def rotate_b(char)
    position = @charmap.find_index(char)
    rotate = position + @rot1.b + @rot2.b
    char = @charmap[rotate % 39]
  end

  def rotate_c(char)
    position = @charmap.find_index(char)
    rotate = position + @rot1.c + @rot2.c
    char = @charmap[rotate % 39]
  end

  def rotate_d(char)
    position = @charmap.find_index(char)
    rotate = position + @rot1.d + @rot2.d
    char = @charmap[rotate % 39]
  end

end

class InputParser

  attr_reader :lines
  attr_accessor :new_lines, :rot_count

  def initialize(file)
    handle = File.open(file)
    @lines = handle.readlines(file).join
    @rot_count = 0
    @new_lines = []
  end

  def rotate_counter
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


  # e = Encrypt.new(50403, 30315)
  # @lines.chars do |char|


end

input = InputParser.new('sample.txt')
input.rotate_counter
puts input.new_lines
