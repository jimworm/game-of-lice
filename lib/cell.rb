class Cell
  attr_accessor :state

  def initialize(board, neighbour_coords, state = false)
    @_board, @_neighbour_coords, @state, @_next_state = board, neighbour_coords, state, nil
  end

  def find_next_state
    sleep(0.00001)
    @_next_state = case neighbours.reduce(0){ |t, n| t + n.to_i }
      when 3 then true
      when 2 then state
      else; false
    end
  end
  
  def neighbours
    @neighbours ||= @_neighbour_coords.map{ |c| @_board.grid[c[0]][c[1]] }
  end
  
  def switch_state
    @state = @_next_state
    @_next_state = nil
  end
  
  def to_i
    @state ? 1 : 0
  end
  
  def to_s
    @state ? 'x' : ' '
  end
end
