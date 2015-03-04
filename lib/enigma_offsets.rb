class Offset

  attr_reader :num

  def initialize(date = CurrentDate.new)
    if date.respond_to?(:data)
      @num = date.data
    else
      @num = date
    end
    @num = @num.reduce do |sum, n|
      sum + n
    end
    @num = @num ** 2
    @num = @num.to_s.reverse[0..3].reverse
  end

  def a
    @num[0].to_i
  end

  def b
    @num[1].to_i
  end

  def c
    @num[2].to_i
  end

  def d
    @num[3].to_i
  end

end

class CurrentDate

  attr_reader :data

  def initialize(t = Time.now)
    @data = t.strftime('%x').split('/')
    @data[0] = @data[0].to_i * 10000
    @data[1] = @data[1].to_i * 100
    @data[2] = @data[2].to_i
    #MAYBE MOVE THE REDUCE METHOD DOWN HERE. AND YA KNOW CHANGE ALL THOSE TESTS.
  end

end
