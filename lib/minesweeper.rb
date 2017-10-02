require File.expand_path('../game_engine', __FILE__)

class MinesweeperGame
  def self.new_game(rows, cols, bombs)
    board = Array.new(rows) { Array.new(cols) }
    
    while bombs > 0
      x = rand(rows)
      y = rand(cols)

      if board[x][y].nil?
        board[x][y] = 'x'

        bombs -= 1
      end
    end

    numbered_board = NumberedBoard.new(board)
    board_config = numbered_board.filled_with_cells

    GameEngine.new(board_config)
  end

  def self.load_game(path)
    save_game = File.open(path).read

    old_game_state = Marshal.load(save_game)
    GameEngine.new(old_game_state[:board])
  end
end
