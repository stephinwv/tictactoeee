# This is the original file that I started with. I went another direction and no longer use this file
# however I wanted to keep it intact and part of the project not only to show my thought process, but
# also for reference or a future teaching tool.
require 'minitest/autorun'
require_relative 'tttfunc.rb'

class Testttt < Minitest::Test
	def test_1
		assert_equal(1,1)
	end
	def test_board
		board = ['1', '2', '3', '4', '5', '6', '7', '8', '9']
		assert_equal(['x', '2', '3', '4', '5', '6', '7', '8', '9'], update_move(board, 'x', 1))
	end
	def test_board_2
		board = ['1', '2', '3', '4', '5', '6', '7', '8', '9']
		assert_equal(['1', '2', '3', '4', '5', '6', 'o', '8', '9'], update_move(board, 'o', 7))
	end
	def test_valid_pos
		board = ['x', '2', '3', '4', '5', '6', 'o', '8', '9']
		position = 8
		assert_equal(true, spot_open?(board, position))
	end
	def test_10
		board = ['x', '2', '3', '4', '5', '6', 'o', '8', '9']
		position = 10
		assert_equal(false, spot_open?(board, position))
	end
	def test_player		
		assert_equal('x', change_player('o'))

	end
	def test_full
		board = ['x', 'o', 'x',  'o', 'x', 'o', 'x', 'o', 'x']
		assert_equal(true, full(board))
	end
	def test_not_full
		board = ['x', '2', 'x',  'o', 'x', 'o', 'x', 'o', 'x']
		assert_equal(false, full(board))
	end
	 def test_board_win_1
        board = ["x","o","x","x","o","o","x","o","x"]
        assert_equal(true, winner?(board))
    end
    def test_board_win_2
        board = ["1","x","3","4","x","6","7","x","9"]
        assert_equal(true, winner?(board))
    end
    def test_board_win_3
        board = ["o","o","o","4","5","6","7","8","9"]
        assert_equal(true, winner?(board))
    end
    def test_board_false
        board = ["o","x","o","4","5","6","7","8","9"]
        assert_equal(false, winner?(board))
    end
    def test_cross_win
        board = ["1","2","x","4","x","6","x","8","9"]
        assert_equal(true, winner?(board))
    end
        

end