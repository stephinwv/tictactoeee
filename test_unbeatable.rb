require 'minitest/autorun'
require_relative 'unbeatable.rb'
require_relative 'board.rb'

class TestUnbeatableAI < Minitest::Test

    def test_win123
        impossible_var = Unbeatable.new('X')
        assert_equal(2, impossible_var.get_move(["X", "X", "", "", "", "", "", "", ""]))
    end
    def test_block
        impossible_var = Unbeatable.new('X')
        assert_equal(1, impossible_var.get_move(['O','','O','','','','','','']))
    end
    def test_center
        impossible_var = Unbeatable.new('X')
        assert_equal(4, impossible_var.get_move(["", "", "", "", "", "", "", "", ""]))
    end
    def test_take_corner
        impossible_var = Unbeatable.new('X')
        assert_equal(0, impossible_var.take_corner(["", "", "", "", "", "", "", "", ""]))
    end
    def test_take_corner_2
        impossible_var = Unbeatable.new('X')
        assert_equal(2, impossible_var.take_corner(["O", "", "", "", "", "", "", "", ""]))
    end
    def test_take_corner_3
        impossible_var = Unbeatable.new('X')
        assert_equal(6, impossible_var.take_corner(["O", "", "X", "", "", "", "", "", ""]))
    end
    def test_take_corner_4
        impossible_var = Unbeatable.new('X')
        assert_equal(8, impossible_var.take_corner(["O", "", "X", "", "", "", "X", "", ""]))
    end
    def test_take_corner_in_func
        impossible_var = Unbeatable.new('X')
        assert_equal(0, impossible_var.get_move(["", "", "", "", "O", "", "", "", ""]))
    end
end