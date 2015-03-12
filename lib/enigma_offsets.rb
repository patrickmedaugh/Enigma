class Offset

  attr_reader :date, :num

  def initialize(date = CurrentDate.new.data)
    @date = date
    @num = @date.to_i ** 2
    @num = @num.to_s.reverse[0..3].reverse
  end

  def a
    num = @num
    num.to_s[0].to_i
  end

  def b
    num = @num
    num.to_s[1].to_i
  end

  def c
    num = @num
    num.to_s[2].to_i
  end

  def d
    num = @num
    num.to_s[3].to_i
  end

end

class CurrentDate

  attr_reader :data

  def initialize(t = Time.now)
    @data = t.strftime('%x').split('/')
    @data[0] = @data[0].to_i * 10000
    @data[1] = @data[1].to_i * 100
    @data[2] = @data[2].to_i
    @data    = @data[0] + @data[1] + @data[2]
  end

end
