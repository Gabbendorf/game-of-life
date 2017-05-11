class World

  attr_reader :cells

  def initialize(cells)
    @cells = cells
  end

  def evolve
    next_generation = []
      @cells.each {|cell|
      neighbours_count = count_live_neighbours(cell.position)
        if ideal_number_of_neighbours(neighbours_count)
          next_generation.push(cell)
        end
        dead_neighbours = dead_cells_around_live_cell(cell.position)
        dead_neighbours.each do |dead_cell|
          count = count_live_neighbours(dead_cell)
          dead_cells = []
          if count == 3
            dead_cells.push(dead_cell)
          end
          dead_cells.uniq.each do |cell|
            new_cell = new_instance_of_cell(cell)
            @cells.push(new_cell)
          end
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

  def dead_cells_around_live_cell(position)
    all_neighbouring_positions = neighbouring_positions(position)
    empty_positions = []
    all_neighbouring_positions.each do |position|
      if !cells_positions.include?(position)
        empty_positions.push(position)
      end
    end
    empty_positions
  end

  def cells_positions
    @cells.map {|cell| cell.position }
  end

  def ideal_number_of_neighbours(count)
    count == 2 || count == 3
  end

  def new_instance_of_cell(position)
    Cell.new(position)
  end

end
