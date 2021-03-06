require_relative 'enigma_offsets'
require_relative 'enigma_encrypt'
require_relative 'enigma_decrypt'
require'pry'

class Brutecrack

  attr_reader   :text
  attr_accessor :key_attempt, :decrypt

  def initialize(filename, file_to_write, offset=nil)
    @text            = File.read(filename)
    @key_attempt     = '00001'
    @offset          = offset || Offset.new.date
    @file_to_write   = file_to_write
  end

  def normalize_text
    @decrypt = Decrypt.new(nil,nil)
    @text = @text.chars.select do |char|
      @decrypt.charmap.include?(char)
    end
    @text = @text.join
  end

  def end_statement
    ['.','.','e','n','d','.','.']
  end

  def last_seven_chars
    @decrypt.decrypted_chars[-7..-1]
  end

  def printed_key_attempt
    (@key_attempt.to_i - 1).to_s.rjust(5, "0")
  end

  def key_attempt_iterator
    until last_seven_chars == end_statement
      @decrypt = Decrypt.new(@key_attempt, @offset)
      @decrypt.decrypted_chars = []
      text = @text.dup
      @decrypt.translate(text)
      @key_attempt = @key_attempt.succ
    end
    @key_attempt = printed_key_attempt
  end

  def filewrite
    File.write("../examples/#{@file_to_write}", @decrypt.decrypted_chars.join)
  end

end

if __FILE__ == $0
   brute = Brutecrack.new(ARGV[0], ARGV[1], ARGV[2])
   brute.normalize_text
   brute.key_attempt_iterator
   brute.filewrite
   puts "Created a #{@file_to_write} file with a key of: #{brute.key_attempt}."
end
