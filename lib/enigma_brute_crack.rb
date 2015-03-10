require_relative 'enigma_offsets'
require_relative 'enigma_encrypt'
require_relative 'enigma_decrypt'
require'pry'

class Brutecrack

  attr_reader   :lines
  attr_accessor :key_s, :new_lines, :key

  def initialize(file, offset)
    handle     = File.open(file)
    @lines     = handle.readlines(file).join.strip
    @key_s     = '00001'
    @offset    = offset
    @new_lines = []
  end

  def key_iterator
    until @new_lines[-7..-1] == [".",".","e","n","d",".","."]
      @new_lines = []
      decrypt = Decrypt.new(@key_s, @offset)
      @lines.chars.map do |char|
        @new_lines << decrypt.rotate_a(char) if decrypt.rot_count == 0
        @new_lines << decrypt.rotate_b(char) if decrypt.rot_count == 1
        @new_lines << decrypt.rotate_c(char) if decrypt.rot_count == 2
        @new_lines << decrypt.rotate_d(char) if decrypt.rot_count == 3
        decrypt.rotate_counter
      end
      @key_s = @key_s.succ
    end
    @key_s = (@key_s.to_i - 1).to_s.rjust(5, "0")
  end

  def writer
    output = File.open("Cracked.txt", "w")
    output.write(@new_lines.join)
    output.close
  end

end

if __FILE__ == $0
   brute = Brutecrack.new(ARGV[0], ARGV[1])
   brute.key_iterator
   brute.writer
   puts "Created a Cracked.txt file with a key of: #{brute.key_s}."
end
