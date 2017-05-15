class World

  attr_reader :cells

  def initialize(cells)
    @cells = cells
  end

  def evolve
  next_generation = []
    @cells.each do |cell|
      if survive?(cell.position)
        next_generation.push(cell)
      end
    end
    positions_of_potential_new_cells.each do |position|
      if resuscitate?(position)
        new_cell = Cell.new(position)
        next_generation.push(new_cell)
      end
    end
    @cells = next_generation
  end

  def survive?(cell_position)
    neighbours_count = neighbours_count(cell_position)
    ideal_neighbours_to_survive?(neighbours_count)
  end

  def resuscitate?(empty_position)
    neighbours_count = neighbours_count(empty_position)
    ideal_neighbours_to_resuscitate?(neighbours_count)
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

  def neighbours_count(position)
    all_neighbouring_positions = neighbouring_positions(position)
    @cells.count {|cell| all_neighbouring_positions.include?(cell.position)}
  end

  def positions_of_potential_new_cells
    all_positions_around_cells = []
    @cells.each { |cell|
      neighbouring_positions(cell.position).each { |position| all_positions_around_cells.push(position)}
    }
    all_positions_around_cells.select {|empty_position| !cells_positions.include?(empty_position)}.uniq
  end

  def cells_positions
    @cells.map {|cell| cell.position }
  end

  def ideal_neighbours_to_survive?(count)
    count == 2 || count == 3
  end

  def ideal_neighbours_to_resuscitate?(count)
    count == 3
  end

end
