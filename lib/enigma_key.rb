class Key

  attr_accessor :keynum

  def initialize(key = Keygen.new)
    if key.is_a?(Keygen)
      @keynum = key.randkey
    else
      @keynum = key
    end
  end

  def a
    key_array = @keynum.to_s.split("")
    (key_array[0].to_i * 10) + (key_array[1].to_i)
  end

  def b
    key_array = @keynum.to_s.split("")
    (key_array[1].to_i * 10) + (key_array[2].to_i)
  end

  def c
    key_array = @keynum.to_s.split("")
    (key_array[2].to_i * 10) + (key_array[3].to_i)
  end

  def d
    key_array = @keynum.to_s.split("")
    (key_array[3].to_i * 10) + (key_array[4].to_i)
  end

end

class Keygen

  attr_reader :randkey

  def initialize
    @randkey = [*("0".."9")].sample(5).reduce{|sum, x| sum + x }.to_i
  end

end
