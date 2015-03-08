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
    if rotate < 0
      rotate = rotate + 39
    end
    char = @charmap[rotate % 39]
  end

  def rotate_b(char)
    position = @charmap.find_index(char)
    rotate = position - @rot1.b - @rot2.b
    if rotate < 0
      rotate = rotate + 39
    end
    char = @charmap[rotate % 39]
  end

  def rotate_c(char)
    position = @charmap.find_index(char)
    rotate = position - @rot1.c - @rot2.c
    if rotate < 0
      rotate = rotate + 39
    end
    char = @charmap[rotate % 39]
  end

  def rotate_d(char)
    position = @charmap.find_index(char)
    rotate = position - @rot1.d - @rot2.d
    if rotate < 0
      rotate = rotate + 39
    end
    char = @charmap[rotate % 39]
  end

end

class DecryptParser

  attr_reader :de_lines
  attr_accessor :de_new_lines, :rot_count, :key, :offset

  def initialize(file, first = Key.new.keynum, second = Offset.new.num)
    @key = first
    @offset = second
    handle = File.open(file)
    @de_lines = handle.readlines(file).join.strip.downcase
    @rot_count = 0
    @de_new_lines = []
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
    decrypt = Decrypt.new(@key, @offset)
    @de_lines.chars do |char|
      if char
        @de_new_lines << decrypt.rotate_a(char) if @rot_count == 0
        @de_new_lines << decrypt.rotate_b(char) if @rot_count == 1
        @de_new_lines << decrypt.rotate_c(char) if @rot_count == 2
        @de_new_lines << decrypt.rotate_d(char) if @rot_count == 3
        self.rotate_counter
      end
    end
     #require'pry';binding.pry
  end

  def writer
    output = File.open("Decrypted.txt", "w")
    output.write(@de_new_lines.join)
    output.close
  end

end


dp = DecryptParser.new(ARGV[0], ARGV[1], ARGV[2])
dp.translate
dp.writer
