class World

  attr_reader :cells

  def initialize(cells)
    @cells = cells
  end

  def evolve
    next_generation = []
      @cells.each {|cell|
        neighbours_count = count_live_neighbours(cell.position)
        if neighbours_count == 2 || neighbours_count == 3
          next_generation.push(cell)
        end
      }
      @cells = next_generation
  end

  def neighbouring_positions(position)
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

  def count_live_neighbours(position)
    all_neighbouring_positions = neighbouring_positions(position)
    @cells.count {|cell| all_neighbouring_positions.include?(cell.position)}
  end

end
