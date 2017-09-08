require File.expand_path('../lib/game_engine', __FILE__)

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

    GameEngine.new(board)
  end
end
