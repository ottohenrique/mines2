class Board
  attr_reader :rows, :cols, :bombs
  attr_reader :state

  def initialize(board_state)
    @state = board_state

    @rows = board_state.size
    @cols = board_state.first.size

    sinalize_bombs_on_board
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

  def sinalize_bombs_on_board
    @bombs = 0

    @state.each_with_index do |row, x|
      row.each_with_index do |col, y|
        if cell(x, y).value != 'x'
          bombs = 0
          siblings(x, y).each do |sibling|
            bombs += 1 if cell(sibling[0], sibling[1]).value == 'x'
          end
          cell(x, y).value = bombs > 0 ? bombs.to_s : ' '
        else
          @bombs += 1
        end
      end
    end
  end

end
