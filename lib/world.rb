class World

  attr_reader :cells

  def initialize(cells)
    @cells = cells
  end

  def evolve
    next_generation = []
      @cells.each {|cell|
        neighbours = count_neighbours(cell.position)
        if neighbours == 2 || neighbours == 3
          next_generation.push(cell)
        end
      }
      @cells = next_generation
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

  def cell?(position)
    @cells.all? { |cell| cell.position == position }
  end

end
