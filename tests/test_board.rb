require 'minitest/autorun'
require File.expand_path('../../lib/board', __FILE__)

describe 'Board' do
  describe 'initialize a board' do
    it 'returns a board size in rows and cols' do
      board = Board.new([[nil, nil, nil]])
      assert_equal 1, board.rows
      assert_equal 3, board.cols
    end
  end

  describe 'siblings cells' do
    it 'calculates siblings for border cells' do 
      board = Board.new([[nil, nil, nil]])

      assert_equal [[0, 1]], board.siblings(0, 0)
      assert_equal [[0, 0], [0, 2]], board.siblings(0, 1)
      assert_equal [[0, 1]], board.siblings(0, 2)
    end

    it 'calculates all siblings for a not-border cell' do
      board = Board.new(Array.new(3) { Array.new(3) })

      assert_equal [[0, 0], [0, 1], [0, 2], [1, 0], [1, 2], [2, 0], [2, 1], [2, 2]], board.siblings(1, 1)
    end
  end

  describe 'access a cell' do
    it 'only access valid cells' do
      board = Board.new([[' ', ' ', ' ']])

      assert_equal true, !!board.cell(0, 1)

      assert_equal false, board.cell(3, 8)
      assert_equal false, board.cell(-1, -1)
    end
  end

  describe 'saving and loading a game' do
    it 'saves the current state of game' do
        board = Board.new([1,2,3])

        current_state = board.save

        b2 = Board.load(current_state)

        assert_equal board.state, b2.state
    end
  end

end
