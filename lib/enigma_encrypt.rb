require_relative 'enigma_key'
require_relative 'enigma_offsets'


class Encrypt

  attr_reader :charmap, :rot1, :rot2
  attr_accessor :rot_count

  def initialize(key, offset)
    @rot1      = Key.new(key)
    @rot2      = Offset.new(offset)
    @charmap   = [*("a".."z"), *("0".."9"), " ", ".", "," ]
    @rot_count = 0
  end

  def rotate_a(char)
    position = @charmap.find_index(char)
    rotate   = position + @rot1.a + @rot2.a

    char     = @charmap[rotate % 39]
  end

  def rotate_b(char)
    position = @charmap.find_index(char)
    rotate   = position + @rot1.b + @rot2.b
    char     = @charmap[rotate % 39]
  end

  def rotate_c(char)
    position = @charmap.find_index(char)
    rotate   = position + @rot1.c + @rot2.c
    char     = @charmap[rotate % 39]
  end

  def rotate_d(char)
    position = @charmap.find_index(char)
    rotate   = position + @rot1.d + @rot2.d
    char     = @charmap[rotate % 39]
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

class EncryptParser

  attr_reader :lines, :offset
  attr_accessor :new_lines, :rot_count, :key

  def initialize(file, first=nil, second=nil)
    @key    = first
    @offset = second
    @key   ||= Keygen.new.randkey
    @offset||= Offset.new.date
    file    = file
    handle  = File.open(file)
    @lines  = handle.readlines(file).join.strip
  end

  def validate_text
    en = Encrypt.new(nil,nil)
    @lines = @lines.split("")
    @lines = @lines.reject do |char|
      en.charmap.include?(char) == false
    end
    @lines = @lines.join.strip
  end

  def translate
    @new_lines = []
    encrypt = Encrypt.new(@key, @offset)
    @lines.chars do |char|
      @new_lines << encrypt.rotate_a(char) if encrypt.rot_count == 0
      @new_lines << encrypt.rotate_b(char) if encrypt.rot_count == 1
      @new_lines << encrypt.rotate_c(char) if encrypt.rot_count == 2
      @new_lines << encrypt.rotate_d(char) if encrypt.rot_count == 3
      encrypt.rotate_counter
    end
  end

  def writer
    output = File.open("Encrypted.txt", "w")
    output.write(@new_lines.join)
    output.close
  end

end

if __FILE__ ==$0
  ep = EncryptParser.new(ARGV[0], ARGV[1], ARGV[2])
  ep.validate_text
  ep.translate
  ep.writer
  puts "Created an Encrypted.txt file with Key: #{ep.key} and Offset: #{ep.offset}"
end
