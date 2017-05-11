require_relative '../lib/world'
require_relative '../lib/cell'

RSpec.describe World do

  let (:world) {World.new}

  describe "World applies the first 3 rules concerning live cells" do
    it "returns no live cells if there is only 1 cell" do
      cell = Cell.new([1,1])
      world = World.new([cell])

      world.evolve

      expect(world.cells).to eq([])
    end

    it "returns cell with 2 neighbours" do
      first_cell = Cell.new([1,1])
      second_cell = Cell.new([2,2])
      third_cell = Cell.new([0,0])
      world = World.new([first_cell, second_cell, third_cell])
      expect(world.count_live_neighbours([1,1])).to eq(2)
      expect(world.count_live_neighbours([2,2])).to eq(1)
      expect(world.count_live_neighbours([0,0])).to eq(1)

      world.evolve

      expect(world.cells).to eq([first_cell])
    end

    it "returns no cells if cells are not neighbours" do
      first_cell = Cell.new([0,10])
      second_cell = Cell.new([0,20])
      third_cell = Cell.new([1,1])
      world = World.new([first_cell, second_cell, third_cell])

      world.evolve

      expect(world.cells).to eq([])
    end

    it "returns how many live cells a position has around" do
      first_cell = Cell.new([0,0])
      second_cell = Cell.new([0,1])
      third_cell = Cell.new([1,0])
      world = World.new([first_cell, second_cell, third_cell])

      neighbours_first_cell = world.count_live_neighbours([0,0])
      neighbours_second_cell = world.count_live_neighbours([0,1])
      neighbours_third_cell = world.count_live_neighbours([1,0])
      neighbours_empty_position = world.count_live_neighbours([1,2])
      neighbours_empty_position2 = world.count_live_neighbours([2,2])

      expect(neighbours_first_cell).to eq(2)
      expect(neighbours_second_cell).to eq(2)
      expect(neighbours_third_cell).to eq(2)
      expect(neighbours_empty_position).to eq(1)
      expect(neighbours_empty_position2).to eq(0)
    end
  end

  describe "World applies the last rule concerning dead cells" do
    xit "resuscitates a dead cell if it has exactly 3 neighbours" do
      first_cell = Cell.new([0,0])
      second_cell = Cell.new([1,0])
      third_cell = Cell.new([0,1])
      world = World.new([first_cell, second_cell, third_cell])

      world.evolve

      expect(world.cells).to eq([first_cell, second_cell, third_cell, Cell.new([1,1])])
    end

    it "returns empty positions around a cell" do
      first_cell = Cell.new([0,0])
      second_cell = Cell.new([0,1])
      world = World.new([first_cell, second_cell])

      expect(world.empty_positions_around_live_cell(first_cell.position)).to eq([[-1,1],[1,1],[1,0],[1,-1],[0,-1],[-1,-1],[-1,0]])
      expect(world.empty_positions_around_live_cell(second_cell.position)).to eq([[-1,2],[0,2],[1,2],[1,1],[1,0],[-1,0],[-1,1]])
    end

    it "returns positions of all cells" do
      first_cell = Cell.new([0,0])
      second_cell = Cell.new([0,1])
      world = World.new([first_cell, second_cell])

      expect(world.cells_positions).to eq([[0,0], [0,1]])
    end
  end
end
