require_relative 'enigma_offsets'
require_relative 'enigma_encrypt'
require_relative 'enigma_decrypt'
require'pry'

class Brutecrack

  attr_reader   :lines
  attr_accessor :key_s, :rot_count

  def initialize(file, offset = Offset.new)
    handle     = File.open(file)
    @lines     = handle.readlines(file).join.strip
    @key_s     = '00001'
    @offset    = offset
    @new_lines = []
  end

  def key_iterator
    while @new_lines[-7..-1] != [".",".","e","n","d",".","."]
      @new_lines = []
      decrypt = Decrypt.new(@key_s, @offset)
      @lines.chars do |char|
        @new_lines << decrypt.rotate_a(char) if decrypt.rot_count == 0
        @new_lines << decrypt.rotate_b(char) if decrypt.rot_count == 1
        @new_lines << decrypt.rotate_c(char) if decrypt.rot_count == 2
        @new_lines << decrypt.rotate_d(char) if decrypt.rot_count == 3
        decrypt.rotate_counter
      end
      @key_s = @key_s.succ
    end
    (@key_s.to_i - 1).to_s.rjust(5, "0")
  end

end

if __FILE__ == $0
   brute = Brutecrack.new(ARGV[0], ARGV[1])
   puts brute.key_iterator
end
