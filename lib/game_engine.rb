require File.expand_path('../../lib/board', __FILE__)
require File.expand_path('../../lib/numbered_board', __FILE__)
require File.expand_path('../../lib/cell', __FILE__)

class GameEngine
  attr_reader :opened_cells, :cells_count, :flags_count

  def initialize(board_config)
    numbered_board = NumberedBoard.new(board_config)

    cells = numbered_board.state.map do |row|
      row.map do |col|
        Cell.new(col)
      end
    end

    @board = Board.new(cells)

    @state = :running

    @opened_cells = 0
    @flags_count = 0
    @bombs_count = board_config.flatten.count { |el| el == 'x' }
  end

  def still_playing?
    @state == :running
  end

  def defeated?
    @state == :defeated
  end

  def victory?
    @state == :victory
  end

  def current_board
    @board.state.map do |row|
      row.map do |col|
        case
        when col.closed?
          '.'
        when col.flagged?
          '?'
        else
          col.value
        end
      end
    end
  end

  def flag!(x, y)
    cell = @board.cell(x, y)
    return false unless cell

    cell.flag!
    
    @flags_count += cell.flagged? ? 1 : -1

    true
  end

  def play!(x, y)
    cell = @board.cell(x, y)

    return false unless cell
    return false unless cell.closed?

    cell.play!

    if cell.value != 'x'
      if cell.value == ' '
        @board.siblings(x, y).each do |sibling|
          play!(sibling[0], sibling[1])
        end
      end

      @opened_cells += 1
      if (cells_count - @opened_cells == @bombs_count)
        @state = :victory
      end
    else
      @state = :defeated
    end

    true
  end

  def cells_count
    @board.rows * @board.cols
  end
end
