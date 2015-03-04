class Key

  attr_reader :keynum

  def initialize(key)
    @keynum = key
  end

  def a
    key_array = @keynum.to_s.split("")
    key_array = (key_array[0].to_i * 10) + (key_array[1].to_i)
  end

  def b
    key_array = @keynum.to_s.split("")
    key_array = (key_array[1].to_i * 10) + (key_array[2].to_i)
  end

  def c
    key_array = @keynum.to_s.split("")
    key_array = (key_array[2].to_i * 10) + (key_array[3].to_i)
  end

  def d
    key_array = @keynum.to_s.split("")
    key_array = (key_array[3].to_i * 10) + (key_array[4].to_i)
  end

end
