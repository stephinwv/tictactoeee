require "minitest/autorun"

require_relative "area.rb"
require_relative "Dog.rb"
require_relative "duck.rb"
class Testanimal < Minitest::Test
	def test_dog
		dog_name = Dog.new("Bowser", "Dowser", "garf!")
		assert_equal("Bowser", dog_name.first_name)
		assert_equal("Dowser", dog_name.last_name)
		assert_equal("garf!", dog_name.sound)
	
	end
	def test_duck
		duck_name = Duck.new("Duck", "McQaukers")
		assert_equal("Duck", duck_name.first_name)
		assert_equal("McQaukers", duck_name.last_name)
		assert_equal("quack", duck_name.sound)
	end
end