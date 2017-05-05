class World

  attr_accessor :cells

  def initialize(cells)
    @cells = cells
  end

  def evolve
    if @cells.size == 3
        @cells.pop(2)
    else
      @cells = []
    end
  end

end
