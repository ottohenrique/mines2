class BasicPrinter
  attr_accessor :board

  def initialize(board)
    @board = board
  end

  def print
    puts header(board.first.size)

    board.each_with_index do |row, i|
      puts "#{x_index(i)} [ #{row.join(' | ')} ] #{x_index(i)}"
    end

    puts header(board.first.size)
  end

  def header(max_y)
    "     " + (0..max_y-1).to_a.map { |n| n.to_s.rjust(3) }.join(' ')

  end

  def x_index(x)
    x.to_s.rjust(3)
  end
end
