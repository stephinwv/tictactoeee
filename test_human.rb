require 'minitest/autorun'
require_relative 'console_human.rb'

class TestPlayer < Minitest::Test

	def test_get_player_move
		player = Human.new('X')
		assert_equal(0, player.get_move('placeholder'))
	end

end