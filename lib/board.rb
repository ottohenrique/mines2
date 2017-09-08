class Board
  attr_reader :rows, :cols, :bombs
  attr_reader :state

  def initialize(board_state)
    @state = board_state

    @rows = board_state.size
    @cols = board_state.first.size
  end

  def siblings(x, y)
    sibls = []

    [-1, 0, 1].each do |i|
      [-1, 0, 1].each do |j|
        unless (i == 0 && j == 0) ||
            (x + i < 0 || x + i >= @rows) ||
            (y + j < 0 || y + j >= @cols)
          sibls << [x + i, y + j]
        end
      end
    end

    sibls
  end

  def cell(x, y)
    return false unless valid_cell?(x, y)

    @state[x][y]
  end

  private
  def valid_cell?(x, y)
    (x >= 0 && x < @rows) &&
      (y >= 0 && y < @cols)
  end
end
