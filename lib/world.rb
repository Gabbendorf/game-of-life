class World

  attr_reader :cells

  def initialize(cells)
    @cells = cells
  end

  def evolve
    if @cells.size == 3
      @cells.pop(2)
    else
      @cells = []
    end
  end

  def potential_neighbours(position)
    x = position[0]
    y = position[1]
    [
      [x-1,y+1],
      [x,y+1],
      [x+1,y+1],
      [x+1,y],
      [x+1,y-1],
      [x,y-1],
      [x-1,y-1],
      [x-1,y]
    ]
  end

  def count_neighbours(position)
    neighbours = potential_neighbours(position)
    count_of_neighbours = []
    @cells.each do |cell|
      if neighbours.include?(cell.position)
        count_of_neighbours.push(cell)
      end
    end
    count_of_neighbours.size
  end

end
