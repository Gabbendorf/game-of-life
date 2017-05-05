require_relative '../lib/world'
require_relative '../lib/cell'

RSpec.describe World do

  it "has no alive cells" do
    dead_cell = Cell.new([])
    world = World.new([dead_cell])
    expect(world.evolve).to eq([])
  end

  describe "World evolves with no cells if it starts with less than 3 cells" do
    it "doesn't have alive cells if it starts with 1 alive cell" do
      alive_cell = Cell.new([0,0])
      world = World.new([alive_cell])
      expect(world.evolve).to eq([])
    end

    it "doesn't have alive cells if it starts with 2 alive cell that are not neighbours" do
      cell_one = Cell.new([0,0])
      cell_two = Cell.new([3,4])
      world = World.new([cell_one, cell_two])
      expect(world.evolve).to eq([])
    end

    it "doesn't have alive cells if it starts with 2 alive cells that are neighbours" do
      cell_one = Cell.new([0,0])
      cell_two = Cell.new([1,0])
      world = World.new([cell_one, cell_two])
      expect(world.evolve).to eq([])
    end
  end

end
