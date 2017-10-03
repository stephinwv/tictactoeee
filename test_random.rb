require 'minitest/autorun'
require_relative '../player_classes.rb'

class TestRandomAI < Minitest::Test

	def test_random_ai_selects_random_position
		random_ai = RandomAI.new('X')
		assert_equal(0, random_ai.get_move([' ', 'X', 'X', 'X', 'X', 'X', 'X', 'X', 'X']))
	end

	def test_random_ai_selects_random_position_345
		random_ai = RandomAI.new('X')
		assert_equal(3, random_ai.get_move(['X', 'X', 'X', ' ', 'X', 'X', 'X', 'X', 'X']))
	end

	def test_random_range_012
		random_ai = RandomAI.new('X')
		assert_equal(true, [0, 1, 2].include?(random_ai.get_move([' ',' ',' ','X','X','X','X','X','X'])))
	end

end