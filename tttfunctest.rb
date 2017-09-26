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
		assert_equal(true, spot_open(board, position))
	end
	def test_10
		board = ['x', '2', '3', '4', '5', '6', 'o', '8', '9']
		position = 10
		assert_equal(false, spot_open(board, position))
	end
end