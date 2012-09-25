class Board
  attr_reader :size, :grid

  def initialize(width, height)
    @width, @height, @size, @grid = width.to_i, height.to_i, (width.to_i * height.to_i), []
    @width.times do |x|
      @grid << []
      @height.times{ |y| @grid[x][y] = Cell.new(self, neighbour_coords(x, y), false) }
    end
  end
  
  def randomize(prob)
    walk { |cell| cell.state = (rand(prob) % prob == 0) }
  end
  
  def populate(file)
    file.each_with_index do |line, y|
      line.split(//).each_with_index do |char, x|
        grid[x][y].state = (char == 'x')
      end
    end
  end

  def neighbour_coords(x, y)
    x_seeds = [x]
    x_seeds << (x - 1) if x > 0
    x_seeds << (x + 1) if x + 1 < @width


    y_seeds = [y]
    y_seeds << (y - 1) if y > 0
    y_seeds << (y + 1) if y + 1 < @height

    coords = []
    x_seeds.each do |i|
      y_seeds.each do |j|
        coords << [i, j] unless i == x and j == y
      end
    end
    coords
  end
  
  def walk(&block)
    grid.flatten.map{ |cell| yield cell }
  end
  
  def life
    grid.flatten.reduce(0){ |t, n| t + n.to_i }
  end
  
  def to_s
    grid.transpose.map{ |line| line.map(&:to_s).join + "\n" }.join
  end
end
