class World

  attr_reader :cells

  def initialize(cells)
    @cells = cells
  end

  def evolve
    if @cells.size == 3
      # @cells.each do |cell|
      if neighbours?(@cells[0],@cells[1]) && neighbours?(@cells[0],@cells[2])
        @cells.pop(2)
      end
      @cells
    end
    @cells = []
  end

  def neighbours(position)
    x = position[0]
    y = position[1]
    potential_neighbours = [
      [x-1,y+1],
      [x,y+1],
      [x+1,y+1],
      [x+1,y],
      [x+1,y-1],
      [x,y-1],
      [x-1,y-1],
      [x-1,y]
    ]
    count_of_neighbours = []
    @cells.each do |cell|
      if potential_neighbours.include?(cell.position)
        count_of_neighbours.push(cell)
      end
    end
    count_of_neighbours.size
  end

end
