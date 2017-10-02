require File.expand_path './lib/board'
require File.expand_path './lib/numbered_board'
require File.expand_path './lib/cell'

class GameEngine
  def initialize(board)
    @board = Board.new(board)

    @state = :running

    @opened_cells = @board.count { |cell| cell.played? } 
    @flags_count = @board.count { |cell| cell.flagged? }
    @bombs_count = @board.count { |cell| cell.value == 'x' }
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

  def score
    {
      opened_cells: @opened_cells,
      closed_cells: cells_count - @opened_cells,
      flags: @flags_count
    }
  end

  def save(path)
    file = File.open(path, 'wb')
    
    current_state = Marshal.dump(score.merge(board: @board.state))

    file.write(current_state)
    file.close
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
