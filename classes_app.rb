class Player

	attr_accessor :marker

	def initialize(marker)
		@marker = marker	
	end
end

class Human < Player

	attr_accessor :marker

end

class Sequential < Player
	#basically finds the next open spot that is an integer. A letter would be skipped
	attr_accessor :marker
	def get_move(board_state)
		board_state.index { |x| x.is_a?(Integer) }
	end

end

class RandomAI < Player
#Determines which index positions are integers, pushes them into an array an
#randomly choosing from that array with a .sample
	attr_accessor :marker

	def get_move(board_state)
		valid_pos = []

		board_state.each_with_index do |val, pos|
			if val.is_a?(Integer)
				valid_pos.push(pos)
			end
		end
		valid_pos.sample
	end

end