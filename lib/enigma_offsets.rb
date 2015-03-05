class Offset

  attr_reader :num

  def initialize(date = CurrentDate.new)
    if date.is_a?(CurrentDate)
      @num = date.data
    else
      @num = date
    end
    @num = @num.to_i ** 2
    @num = @num.to_s.reverse[0..3].reverse.to_i
  end

  def a
    @num.to_s[0].to_i
  end

  def b
    @num.to_s[1].to_i
  end

  def c
    @num.to_s[2].to_i
  end

  def d
    @num.to_s[3].to_i
  end

end

class CurrentDate

  attr_reader :data

  def initialize(t = Time.now)
    @data = t.strftime('%x').split('/')
    @data[0] = @data[0].to_i * 10000
    @data[1] = @data[1].to_i * 100
    @data[2] = @data[2].to_i
    @data = @data[0] + @data[1] + @data[2]
  end

end
