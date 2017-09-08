require 'minitest/autorun'
require File.expand_path('../../lib/numbered_board', __FILE__)

describe 'NumberedBoard' do
  it 'returns a board with numbers of near bombs' do
    board_config = [ [ nil, nil, 'x' ],
                     [ nil, nil, 'x' ],
                     [ nil, nil, nil ] ]

    board = NumberedBoard.new(board_config)

    assert_equal board.state, [ [' ', '2', 'x'],
                                [' ', '2', 'x'],
                                [' ', '1', '1'] ]
  end
end
