require_relative '../lib/world'
require_relative '../lib/cell'

RSpec.describe World do

  let (:world) {World.new}

  describe "applies the first 3 rules concerning live cells" do
    it "returns no live cells if there is only 1 cell" do
      cell = Cell.new([1,1])
      world = World.new([cell])

      world.evolve

      expect(world.empty?).to eq(true)
    end

    it "returns cell with 2 neighbours" do
      first_cell = Cell.new([1,1])
      second_cell = Cell.new([2,2])
      third_cell = Cell.new([0,0])
      world = World.new([first_cell, second_cell, third_cell])
      expect(world.neighbours_count([1,1])).to eq(2)
      expect(world.neighbours_count([2,2])).to eq(1)
      expect(world.neighbours_count([0,0])).to eq(1)

      world.evolve

      expect(world.cells).to eq([first_cell])
    end

    it "returns no cells if cells are not neighbours" do
      first_cell = Cell.new([0,10])
      second_cell = Cell.new([0,20])
      third_cell = Cell.new([1,1])
      world = World.new([first_cell, second_cell, third_cell])

      world.evolve

      expect(world.empty?).to eq(true)
    end
  end

  it "returns the number of live neighbours" do
    first_cell = Cell.new([0,0])
    second_cell = Cell.new([0,1])
    third_cell = Cell.new([1,0])
    world = World.new([first_cell, second_cell, third_cell])

    neighbours_first_cell = world.neighbours_count([0,0])
    neighbours_second_cell = world.neighbours_count([0,1])
    neighbours_third_cell = world.neighbours_count([1,0])
    neighbours_empty_position = world.neighbours_count([1,2])
    neighbours_empty_position2 = world.neighbours_count([2,2])

    expect(neighbours_first_cell).to eq(2)
    expect(neighbours_second_cell).to eq(2)
    expect(neighbours_third_cell).to eq(2)
    expect(neighbours_empty_position).to eq(1)
    expect(neighbours_empty_position2).to eq(0)
  end

  it "returns positions of all live cells" do
    first_cell = Cell.new([0,0])
    second_cell = Cell.new([0,1])
    third_cell = Cell.new([20,5])
    world = World.new([first_cell, second_cell, third_cell])

    positions_of_cells = world.cells_positions

    expect(positions_of_cells).to eq([[0,0], [0,1], [20,5]])
  end

  it "returns positions around live cells where new cells could resuscitate" do
    first_cell = Cell.new([0,0])
    second_cell = Cell.new([0,1])
    third_cell = Cell.new([1,1])
    world = World.new([first_cell, second_cell, third_cell])

    potential_resuscitating_cells = world.positions_of_potential_new_cells

    expect(potential_resuscitating_cells).to contain_exactly([-1,1],[-1,2],[0,2],[1,2],[1,0],[1,-1],[0,-1],[-1,-1],[-1,0],[2,2],[2,1],[2,0])
  end

  describe "applies the last rule concerning dead cells" do
    it "resuscitates dead cells if they have exactly 3 live neighbours" do
      first_cell = Cell.new([0,0])
      second_cell = Cell.new([1,0])
      third_cell = Cell.new([0,1])
      fourth_cell = Cell.new([2,-1])
      fifth_cell = Cell.new([-1,-1])
      world = World.new([first_cell, second_cell, third_cell, fourth_cell, fifth_cell])
      positions_of_dead_cells_with_3_neighbours = [[1,1], [1,-1],[0,-1],[-1,0]]

      world.evolve

      expect(world.cells_positions).to eq([[0,0], [1,0], [0,1]] + positions_of_dead_cells_with_3_neighbours)
    end
  end

end
