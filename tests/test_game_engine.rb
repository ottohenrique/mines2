require 'minitest/autorun'
require File.expand_path('../../lib/game_engine', __FILE__)

describe GameEngine do
  describe 'flags a game cell' do
    it 'successfully marks a closed cell with flag' do
      game = GameEngine.new([[Cell.new(' ')]], 0, 0, 0)

      assert_equal true, game.flag!(0, 0)
    end
  end

  describe 'plays a cell' do
    it 'only plays closed cells' do
      game = GameEngine.new([[Cell.new(' ')]], 0, 0, 0)

      assert_equal true, game.play!(0,0)
      assert_equal false, game.play!(0,0)
    end

    it 'plays siblins cells' do
      game = GameEngine.new([[Cell.new(' '), Cell.new('1'), Cell.new('x')]], 0, 0, 1)

      game.play!(0, 0)

      assert_equal [[' ', '1', '.']], game.current_board
    end
  end

  describe 'victory and defeat' do
    it 'lost a game when hit a bomb' do
      game = GameEngine.new([[Cell.new('x')]], 0, 0, 1)

      assert_equal true, game.still_playing?

      game.play!(0, 0)

      assert_equal false, game.still_playing?
      assert_equal true, game.defeated?
    end

    it 'wins the game when there are only bombs left' do
      game = GameEngine.new([[Cell.new(' '), Cell.new('1'), Cell.new('x')]], 0, 0, 1)

      game.play!(0, 0)

      assert_equal true, game.victory?
      assert_equal false, game.still_playing?
    end
  end

  describe 'game score' do
    it 'gives a helper method to access scores values' do
      game = GameEngine.new([[Cell.new(' '), Cell.new('1'), Cell.new('x')]], 0, 0, 1)

      assert_equal 3, game.score[:closed_cells]
      assert_equal 0, game.score[:opened_cells]
      assert_equal 0, game.score[:flags]
    end
  end

end
