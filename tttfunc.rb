def update_move(board, player, position)
	p board
	p player
	p position
	board[position-1] = player
	board
end

def spot_open?(board, position)
	if board[position-1] == 'x' || board[position-1] == 'o'
		false
	elsif position>=10 || position<=0
		false
	else
		true
	end
end

def change_player(player)
	
	if player == 'x'
			current_player = 'o'
	elsif player == 'o'
			current_player = "x"
	end
	puts "current_player is #{current_player}"
	current_player
end
def full(board)
	if board.all? {|space| space.include?('o') || space.include?('x')}
		full = true
	
	else
		full = false
	end
	puts "full is #{full}"
	full
end