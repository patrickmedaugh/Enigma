require_relative 'enigma_key'
require_relative 'enigma_offsets'
require 'pry'


class Encrypt

  attr_reader :charmap, :key, :offset
  attr_accessor :rotate_count, :encrypted_chars

  def initialize(key, offset)
    @key             = Key.new(key)
    @offset          = Offset.new(offset)
    @charmap         = [*("a".."z"), *("0".."9"), " ", ".", "," ]
    @rotate_count    = 0
    @encrypted_chars = []
  end

  def rotate_a(char)
    position = @charmap.find_index(char)
    rotate   = position + @key.a + @offset.a
    char     = @charmap[rotate % @charmap.length]
  end

  def rotate_b(char)
    position = @charmap.find_index(char)
    rotate   = position + @key.b + @offset.b
    char     = @charmap[rotate % @charmap.length]
  end

  def rotate_c(char)
    position = @charmap.find_index(char)
    rotate   = position + @key.c + @offset.c
    char     = @charmap[rotate % @charmap.length]
  end

  def rotate_d(char)
    position = @charmap.find_index(char)
    rotate   = position + @key.d + @offset.d
    char     = @charmap[rotate % @charmap.length]
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
      @encrypted_chars << rotate_a(char) if @rotate_count == 0
      @encrypted_chars << rotate_b(char) if @rotate_count == 1
      @encrypted_chars << rotate_c(char) if @rotate_count == 2
      @encrypted_chars << rotate_d(char) if @rotate_count == 3
      rotate_counter
    end
    @encrypted_chars.join
  end

end

class EncryptParser

  attr_reader :text, :offset, :key, :encrypt

  def initialize(filename, key=nil, offset=nil)
    @key     = key || Keygen.new.randkey
    @offset  = offset || Offset.new.date
    @text    = File.read(filename)
    @encrypt = Encrypt.new(@key, @offset)
  end

  def normalize_text
    @text = @text.chars.select do |char|
      @encrypt.charmap.include?(char)
    end
    @text = @text.join
  end

  def filewrite
    File.write('../examples/Encrypted.txt', @encrypt.encrypted_chars.join)
  end

end

if __FILE__ == $0
  ep = EncryptParser.new(ARGV[0], ARGV[1], ARGV[2])
  ep.normalize_text
  ep.encrypt.translate(ep.text)
  ep.filewrite
  puts "Created an Encrypted.txt file with Key: #{ep.key} and Offset: #{ep.offset}"
end
