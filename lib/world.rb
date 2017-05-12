class World

  attr_reader :cells

  def initialize(cells)
    @cells = cells
  end

  def evolve
    next_generation = []
      @cells.each {|cell|
      neighbours_count = count_live_neighbours(cell.position)
        if number_of_neighbours_to_survive(neighbours_count)
          next_generation.push(cell)
        end
      }
      positions_of_potential_resuscitating_cells.each do |position|
        count = count_live_neighbours(position)
        if number_of_neighbours_to_resuscitate(count)
          new_cell = new_instance_of_cell(position)
          next_generation.push(new_cell)
        end
      end
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

  def positions_of_potential_resuscitating_cells
    all_positions_around_cells = []
    @cells.each { |cell|
      neighbours_positions = neighbouring_positions(cell.position)
        neighbours_positions.each do |position|
          all_positions_around_cells.push(position)
        end
    }
    all_positions_around_cells.select {|empty_position| !cells_positions.include?(empty_position)}.uniq
  end

  def cells_positions
    @cells.map {|cell| cell.position }
  end

  def number_of_neighbours_to_survive(count)
    count == 2 || count == 3
  end

  def number_of_neighbours_to_resuscitate(count)
    count == 3
  end

  def new_instance_of_cell(position)
    Cell.new(position)
  end

end
