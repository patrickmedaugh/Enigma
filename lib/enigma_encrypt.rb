require_relative 'enigma_key'
require_relative 'enigma_offsets'


class Encrypt

  attr_reader :charmap, :rot1, :rot2
  #ASK SOMEONE SMART ABOUT TOP LEVEL VALIDATION!!!!!!!!!!!!!!!!!!!!!!!
  #ASK THEM!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!! (EncryptParser)
  #key will be Key object or Fixnum. offset will be Offset object or Fixnum
  #if key is a key object need to extract the fixnum "keynum"
  #if offset is an offset object, need to extract the fixnum "num"
  def initialize(key = Key.new, offset = CurrentDate.new)
    if key.is_a?(Key)
      @rot1 = Key.new(key.keynum)
    else
      @rot1 = Key.new(key)
    end
    if offset.is_a?(Offset)
      @rot2 = Offset.new(offset.num)
    else
      @rot2 = Offset.new(offset)
    end
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

class EncryptParser

  attr_reader :lines, :key, :offset
  attr_accessor :new_lines, :rot_count

  def initialize(file, key = Key.new, offset = Offset.new)
    handle = File.open(file)
    @lines = handle.readlines(file).join.strip
    @rot_count = 0
    @new_lines = []
    @key = key
    @offset = offset
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
    encrypt = Encrypt.new(@key, @offset)
    @lines.chars do |char|
      @new_lines << encrypt.rotate_a(char) if @rot_count == 0
      @new_lines << encrypt.rotate_b(char) if @rot_count == 1
      @new_lines << encrypt.rotate_c(char) if @rot_count == 2
      @new_lines << encrypt.rotate_d(char) if @rot_count == 3
      self.rotate_counter
    end
  end
end


# input = EncryptParser.new('sample.txt', 41521, 020315)
# input.translate
# puts input.new_lines
# puts input.new_lines.class
