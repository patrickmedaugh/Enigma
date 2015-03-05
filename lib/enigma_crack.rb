require_relative 'enigma_offsets'
require_relative 'enigma_encrypt'


class Crack

  def initialize
    handle = File.open(file)
    @end = handle.readlines(file).join.strip
    @end = @end.to_s.reverse.[0..6].reverse
  end

  def backmap
    offset  = Offset.new
    encrypt = Encrypt.new
  end



end
