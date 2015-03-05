require_relative 'enigma_key'
require_relative 'enigma_offsets'
require_relative 'enigma_encrypt'


class Decrypt

  attr_reader :charmap, :rot1, :rot2

  def initialize(key, offset)
    @rot1 = Key.new(key)
    @rot2 = Offset.new(offset)
    @charmap = [*("a".."z"), *("0".."9"), " ", ".", "," ]
  end

  def rotate_a(char)
    position = @charmap.find_index(char)
    rotate = position - @rot1.a - @rot2.a
    char = @charmap[rotate % 39]
  end

  def rotate_b(char)
    position = @charmap.find_index(char)
    rotate = position - @rot1.b - @rot2.b
    char = @charmap[rotate % 39]
  end

  def rotate_c(char)
    position = @charmap.find_index(char)
    rotate = position - @rot1.c - @rot2.c
    char = @charmap[rotate % 39]
  end

  def rotate_d(char)
    position = @charmap.find_index(char)
    rotate = position - @rot1.d - @rot2.d
    char = @charmap[rotate % 39]
  end

end

class DecryptParser

  attr_reader :lines, :encrypt
  attr_accessor :new_lines, :rot_count, :key, :offset

  def initialize(file, first = Key.new.keynum, second = Offset.new.num)
    @key = first
    @offset = second
    # require'pry';binding.pry
    handle = File.open(file)
    @lines = handle.readlines(file).join.strip
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

  def translate
    @decrypt = Decrypt.new(@key, @offset)
    @lines.chars do |char|
      @new_lines << encrypt.rotate_a(char) if @rot_count == 0
      @new_lines << encrypt.rotate_b(char) if @rot_count == 1
      @new_lines << encrypt.rotate_c(char) if @rot_count == 2
      @new_lines << encrypt.rotate_d(char) if @rot_count == 3
      self.rotate_counter
    end
  end
end
