require 'minitest/autorun'
require_relative 'board.rb'

class TestBoard < Minitest::Test

	def test_board_return
		board_new = Board.new
		assert_equal(Array.new(9, ""), board_new.ttt_board)
	end
	def test_update_1st_postition
		board_new = Board.new
		board_new.update_position(0, "X")
		assert_equal(["X", "", "", "", "", "", "", "", ""], board_new.ttt_board)
	end
	def test_valid_position
		board_new = Board.new
		board_new.update_position(0, "X")
		board_new.update_position(8, "O")
		assert_equal(["X", "", "", "", "", "", "", "", "O"], board_new.ttt_board)	
	end
	def test_full_but_1
		board_new = Board.new
		board_new.ttt_board = ["X", "O", "X", "O", "X", "O", "X", "O", ""]
		board_new.update_position(8, "O")
		assert_equal(["X", "O", "X", "O", "X", "O", "X", "O", "O"], board_new.ttt_board)		
	end
	def test_valid_position
		board_new = Board.new
		board_new.ttt_board = ["X", "", "", "", "", "", "", "", "O"]
		assert_equal(true, board_new.valid_position?(3))
		assert_equal(false, board_new.valid_position?(0))
		assert_equal(true, board_new.valid_position?(7))
	end
	def test_full_board
		board_new = Board.new
		board_new.ttt_board = ["X", "", "", "", "", "", "", "", "O"]
		assert_equal(false, board_new.full_board?)
	end
	def test_full_board2
		board_new = Board.new
		board_new.ttt_board = ["X", "O", "X", "O", "X", "O", "X", "O", "X"]
		assert_equal(true, board_new.full_board?)
	end
	
end