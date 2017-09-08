require File.expand_path('./lib/board')

class NumberedBoard < Board
  def initialize(config)
    super(config)
  end

  def state
    @state.each_with_index do |row, x|
      row.each_with_index do |col, y|
        if @state[x][y] != 'x'
          bombs = 0
          siblings(x, y).each do |sib|
            bombs += 1 if @state[sib[0]][sib[1]] == 'x'
          end

          @state[x][y] = bombs > 0 ? bombs.to_s : ' '
        end
      end
    end

    @state
  end
end
