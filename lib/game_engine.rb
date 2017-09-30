require File.expand_path './lib/board'
require File.expand_path './lib/numbered_board'
require File.expand_path './lib/cell'

class GameEngine
  attr_accessor :opened_cells, :cells_count, :flags_count, :bombs_count
  attr_accessor :board

  def initialize(board_config = nil)
    if board_config
        numbered_board = NumberedBoard.new(board_config)

        cells = numbered_board.state.map do |row|
          row.map do |col|
            Cell.new(col)
          end
        end

        @board = Board.new(cells)

        @opened_cells = 0
        @flags_count = 0
        @bombs_count = board_config.flatten.count { |el| el == 'x' }
    end

    @state = :running
  end

  def self.load(old_game)
    game = GameEngine.new

    game.board = Board.load(old_game[:state])
    game.opened_cells = old_game[:opened_cells]
    game.flags_count = old_game[:flags]
    game.bombs_count = old_game[:bombs]

    game
  end

  def save(path)
    file = File.open(path, 'wb')

    score = {
        opened_cells: @opened_cells,
        flags: @flags_count,
        bombs: @bombs_count,
        state: @board.save
    }

    file.write(Marshal.dump(score))
    file.close
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
