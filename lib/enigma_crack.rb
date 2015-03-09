require_relative 'enigma_offsets'
require_relative 'enigma_encrypt'


class Crack

  attr_reader :last7, :position

  def initialize(file, offset = Offset.new)
    handle     = File.open(file)
    @last7     = handle.readlines(file).join.strip
    @last7     = @last7.to_s.reverse[0..6].reverse.split("")
    @positions = []
    @offset    = Offset.new(offset)
  end

  def backmap
    expected  = [37,37, 4, 13, 3, 37, 37]
    en        = Encrypt.new(nil,nil)
    charmap   = en.charmap
    rot_count = en.rot_count
    i=0
    expected.each do |char|
      case rot_count
      when 0
        last7pos = charmap.index(@last7[i])
        x = char - (@offset.a + last7pos)
        x = x + 39 if x < 0
      when 1
        last7pos = charmap.index(@last7[i])
        x = char - (@offset.a + last7pos)
        x = x + 39 if x < 0
      when 2
        last7pos = charmap.index(@last7[i])
        x = char - (@offset.a + last7pos)
        x = x + 39 if x < 0
      when 3
        last7pos = charmap.index(@last7[i])
        x = char - (@offset.a + last7pos)
        x = x + 39 if x < 0
      end
      rot_count = en.rotate_counter
      @positions << x
      i+=1
    end
    @positions
  end

end

if __FILE__ == $0
   crack = Crack.new(ARGV[0], ARGV[1])
   puts crack.backmap
end
