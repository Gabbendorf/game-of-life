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
      resuscitate_cell(cell.position)
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

  def empty_positions_around_live_cells
    positions_of_potential_resuscitating_cells = []
    all_neighbouring_positions = []
    @cells.each { |cell|
      neighbours_positions = neighbouring_positions(cell.position)
        neighbours_positions.each do |position|
          all_neighbouring_positions.push(position)
        end
    }
    all_neighbouring_positions.each do |neighbouring_position|
      if !cells_positions.include?(neighbouring_position)
        positions_of_potential_resuscitating_cells.push(neighbouring_position)
      end
    end
      positions_of_potential_resuscitating_cells.uniq
  end

  # def empty_positions_around_live_cell(position)
  #   all_neighbouring_positions = neighbouring_positions(position)
  #   empty_positions_with_neighbours = []
  #   all_neighbouring_positions.each do |neighbouring_position|
  #     if !cells_positions.include?(neighbouring_position)
  #       empty_positions_with_neighbours.push(neighbouring_position)
  #     end
  #   end
  #   empty_positions_with_neighbours
  # end

  def cells_positions
    @cells.map {|cell| cell.position }
  end

  def number_of_neighbours_to_survive(count)
    count == 2 || count == 3
  end

  def new_instance_of_cell(position)
    Cell.new(position)
  end

  def resuscitate_cell(position)
    dead_neighbours = empty_positions_around_live_cell(position)
    dead_neighbours.each do |dead_cell|
      count = count_live_neighbours(dead_cell)
      resuscitated_cells = []
      if number_of_neighbours_to_resuscitate(count)
        resuscitated_cells.push(dead_cell)
      end
      resuscitated_cells.uniq.each do |cell|
        new_cell = new_instance_of_cell(cell)
        @cells.push(new_cell)
      end
    end
  end

  def number_of_neighbours_to_resuscitate(count)
    count == 3
  end

  def new_cell(dead_cells)
    dead_cells.uniq.each do |cell|
     new_instance_of_cell(cell)
    end
  end

end
