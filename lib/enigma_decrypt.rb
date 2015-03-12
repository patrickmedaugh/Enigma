require_relative 'enigma_key'
require_relative 'enigma_offsets'
require 'pry'

class Decrypt

  attr_reader :charmap, :offset
  attr_accessor :rotate_count, :decrypted_chars, :key

  def initialize(key, offset)
    @key             = Key.new(key)
    @offset          = Offset.new(offset)
    @charmap         = [*("a".."z"), *("0".."9"), " ", ".", "," ]
    @rotate_count    = 0
    @decrypted_chars = []
  end

  def rotate_a(char)
    position = @charmap.find_index(char)
    rotate   = position - (@key.a + @offset.a)
    rotate   = rotate + @charmap.length if rotate < 0
    char     = @charmap[rotate]
  end

  def rotate_b(char)
    position = @charmap.find_index(char)
    rotate   = position - (@key.b + @offset.b)
    rotate   = rotate + @charmap.length if rotate < 0
    char     = @charmap[rotate]
  end

  def rotate_c(char)
    position = @charmap.find_index(char)
    rotate   = position - (@key.c + @offset.c)
    rotate   = rotate + @charmap.length if rotate < 0
    char     = @charmap[rotate]
  end

  def rotate_d(char)
    position = @charmap.find_index(char)
    rotate   = position - (@key.d + @offset.d)
    rotate   = rotate + @charmap.length if rotate < 0
    char     = @charmap[rotate]
  end

  def rotate_counter
    if @rotate_count != 3
      @rotate_count +=1
    else
      @rotate_count = 0
    end
  end

  def translate(text)
    text.chars do |char|
      @decrypted_chars << rotate_a(char) if @rotate_count == 0
      @decrypted_chars << rotate_b(char) if @rotate_count == 1
      @decrypted_chars << rotate_c(char) if @rotate_count == 2
      @decrypted_chars << rotate_d(char) if @rotate_count == 3
      rotate_counter
    end
    @decrypted_chars.join
  end
end

class DecryptParser

  attr_reader :text, :offset, :key, :decrypt

  def initialize(filename, key=nil, offset=nil)
    @key     = key || Keygen.new.randkey
    @offset  = offset || Offset.new.date
    @text    = File.read(filename)
    @decrypt = Decrypt.new(@key, @offset)
  end

  def normalize_text
    @text = @text.chars.select do |char|
      @decrypt.charmap.include?(char)
    end
    @text = @text.join
  end

  def filewrite
    File.write('../examples/Decrypted.txt', @decrypt.decrypted_chars.join)
  end

end

if __FILE__ == $0
  dp = DecryptParser.new(ARGV[0], ARGV[1], ARGV[2])
  dp.normalize_text
  dp.decrypt.translate(dp.text)
  dp.filewrite
  puts "Created a Decrypted.txt file with Key: #{dp.key} and Offset: #{dp.offset}"
end
