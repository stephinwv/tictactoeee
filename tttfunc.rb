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

