class World

  attr_reader :cells

  def initialize(cells)
    @cells = cells
  end

  def evolve
    if @cells.length <= 2
      []
    end
  end

  def neighbour?

  end

end
