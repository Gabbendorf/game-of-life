require_relative '../lib/world'
require_relative '../lib/cell'

RSpec.describe World do

  let (:world) {World.new}

  it "returns no live cells if there is only 1 cell" do
    cell = Cell.new([1,1])
    world = World.new([cell])
    world.evolve
    expect(world.cells).to eq([])
  end

  it "returns cell with 2 neighbours" do
    first_cell = Cell.new([0,0])
    second_cell = Cell.new([0,1])
    third_cell = Cell.new([1,0])
    world = World.new([first_cell, second_cell, third_cell])
    world.evolve
    expect(world.cells).to eq([first_cell])
  end

end
