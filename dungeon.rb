class Room

  attr_accessor :wallfill

  def initialize(height, width)
    @height = height
    @width = width
  end

  def roomgen
    i = 0
    @wallfill = []
    wall_array = []
    @northroomwall = []
    (@width).times{@northroomwall << "#"}
    (@height - 2).times do
      wall_array = "#"
      (@width-2).times{wall_array << " "}
      wall_array << "#"
      @wallfill << wall_array
      @wallfill << "\n"
      i += 1
    end
  end

  def printout
    print @northroomwall.join
    print @wallfill.join
    print @northroomwall.join
  end

  def wallgen
    i=0
    x = 1
    start = rand(2..(@northroomwall.count - 2))
    turn = rand (2..(@height - 2))
    turn.times do
      if @wallfill[i][start] == " "
       @wallfill[i][start] = "#"
      end
    i += 1
    end
    while x < start
       @wallfill[i][x] = "#"
       x +=1
    end
  end

end

room = Room.new(20, 40)
room.roomgen
room.wallgen
room.wallgen
room.printout
