class Human
attr_reader :marker

def initialize(marker)
	@marker = marker
end
def get_move(board)
puts "Make a move"
move = gets.chomp.to_i
	if spot_open?(position)
		update = update_move
end
def change_player(player)
	
	if player == 'x'
			player = 'o'
	elsif player == 'o'
			player = "x"
	end
	player

end
end