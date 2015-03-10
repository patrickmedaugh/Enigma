require_relative 'enigma_key'
require_relative 'enigma_offsets'
require_relative 'enigma_encrypt'


class Decrypt

  attr_reader :charmap, :rot1, :rot2, :rot_count

  def initialize(key, offset)
    @rot1      = Key.new(key)
    @rot2      = Offset.new(offset)
    @charmap   = [*("a".."z"), *("0".."9"), " ", ".", "," ]
    @rot_count = 0
  end

  def rotate_a(char)
    position = @charmap.find_index(char)
    rotate   = position - (@rot1.a + @rot2.a)
    if rotate < 0
      rotate = rotate + 39
    end
    char = @charmap[rotate % 39]
  end

  def rotate_b(char)
    position = @charmap.find_index(char)
    rotate   = position - (@rot1.b + @rot2.b)
    if rotate < 0
      rotate = rotate + 39
    end
    char = @charmap[rotate % 39]
  end

  def rotate_c(char)
    position = @charmap.find_index(char)
    rotate   = position - (@rot1.c + @rot2.c)
    if rotate < 0
      rotate = rotate + 39
    end
    char = @charmap[rotate % 39]
  end

  def rotate_d(char)
    position = @charmap.find_index(char)
    rotate   = position - (@rot1.d + @rot2.d)
    if rotate < 0
      rotate = rotate + 39
    end
    char = @charmap[rotate % 39]
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

end

class DecryptParser

  attr_reader :lines, :offs
  attr_accessor :new_lines, :rot_count, :key, :offset

  def initialize(file, first=nil, second=nil)
    @key    = first
    @offset = second
    handle  = File.open(file)
    @lines  = handle.readlines(file).join.strip
  end

  def validate_text
    de     = Decrypt.new(nil,nil)
    @lines = @lines.split("")
    @lines = @lines.reject do |char|
      de.charmap.include?(char) == false
    end
    @lines = @lines.join
  end

  def translate
    @new_lines = []
    decrypt = Decrypt.new(@key, @offset)
    @lines.chars do |char|
      @new_lines << decrypt.rotate_a(char) if decrypt.rot_count == 0
      @new_lines << decrypt.rotate_b(char) if decrypt.rot_count == 1
      @new_lines << decrypt.rotate_c(char) if decrypt.rot_count == 2
      @new_lines << decrypt.rotate_d(char) if decrypt.rot_count == 3
      decrypt.rotate_counter
    end
  end

  def writer
    output = File.open("Decrypted.txt", "w")
    output.write(@new_lines.join)
    output.close
  end

end

if __FILE__ == $0
  dp = DecryptParser.new(ARGV[0], ARGV[1], ARGV[2])
  dp.validate_text
  dp.translate
  dp.writer
  puts "Created a Decrypted.txt file with Key: #{dp.key} and Offset: #{dp.offset}"
end
