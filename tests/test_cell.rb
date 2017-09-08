require 'minitest/autorun'
require File.expand_path('../../lib/game_engine', __FILE__)

describe 'Cell' do
  describe 'states' do
    it 'starts a cell with a closed state' do
      cell = Cell.new(nil)

      assert_equal true, cell.closed?
    end

    it 'changes a cell to opened after a play' do
      cell = Cell.new(nil)
      cell.play!

      assert_equal true, cell.played?
      assert_equal false, cell.closed?
    end

    describe 'flags' do
      it 'flags a closed cell' do
        cell = Cell.new(nil)

        assert_equal true, cell.flag!

        assert_equal false, cell.closed?
        assert_equal true, cell.flagged?
      end

      it 'cant flag a played cell' do
        cell = Cell.new(nil)

        cell.play!

        assert_equal false, cell.flag!
      end
    end
  end
end
