require_relative 'enigma_offsets'
require_relative 'enigma_encrypt'


class Brutecrack

  attr_reader :last7, :position

  def initialize(file)
    handle    = File.open(file)
    @last7    = handle.readlines(file, "w").join.strip
    @last7    = @last7.to_s.reverse[0..6].reverse.split("")
    @position = []
    @rot_count= 0
  end

  def key_iterator
    encrypt = Encrypt.new()
  end

end
