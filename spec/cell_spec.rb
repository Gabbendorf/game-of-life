require_relative '../lib/cell'
require_relative '../lib/coordinates'

RSpec.describe Cell do

  it "is alive and has 2 coordinates" do
    cell = Cell.new([0,0])
    x = cell.position[0]
    y = cell.position[1]
    expect(cell.position).to eq([0,0])
    expect(x).to eq(0)
    expect(y).to eq(0)
  end

  it "is alive and can have negative coordinates" do
    cell = Cell.new([-7,-9])
    x = cell.position[0]
    y = cell.position[1]
    expect(cell.position).to eq([-7,-9])
    expect(x).to eq(-7)
    expect(y).to eq(-9)
  end

end
