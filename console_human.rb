
class Player

	attr_accessor :marker

	def initialize(marker)
		@marker = marker	
	end
end

class Human < Player

	attr_accessor :marker

	def get_move(board_state)
		
		puts 'Enter 1-9 to choose your square: '
		puts " 1 | 2 | 3 "
		puts "-----------"
		puts " 4 | 5 | 6 "
		puts "-----------"
		puts " 7 | 8 | 9 "

		move = gets.chomp.to_i - 1
	end

end

class Sequential < Player

	attr_accessor :marker

	def get_move(board_state)

		board_state.index(" ")
	end

end

class RandomAI < Player

	attr_accessor :marker

	def get_move(board_state)

		valid_pos = []

		board_state.each_with_index do |val, pos|
			if val == ' '
				valid_pos.push(pos)
			end
		end
		valid_pos.sample
	end

end