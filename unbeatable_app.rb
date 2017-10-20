class UnbeatableAI

	attr_accessor :marker, :opponent

	def initialize(marker)
		@marker = marker
		@opponent = get_opponent(@marker)	
	end

	def get_move(ttt_board)
		#move is set at 50 initially in part to set value at start to be changed by results
    	#from the following functions. If in the console move returns 50 we know something is very wrong.
    	# This is the order of which functions are called in order to establish where the computer should 
    	#place the next move.
		move = 50

		if win(ttt_board) <= 8
			move = win(ttt_board)

		elsif block(ttt_board) <= 8
			move = block(ttt_board)

		elsif check_for_fork(ttt_board) <= 8
			move = check_for_fork(ttt_board)

		elsif block_fork(ttt_board) <= 8
			move = block_fork(ttt_board)

		elsif take_center(ttt_board) <= 8
			move = take_center(ttt_board)

		elsif opposite_corner(ttt_board) <= 8
			move = opposite_corner(ttt_board)

		elsif empty_corner(ttt_board) <= 8
			move = empty_corner(ttt_board)

		else empty_side(ttt_board)
			move = empty_side(ttt_board)
		end

		move

	end

	def win(ttt_board)
		#Win: If the player has two in a row, they can place a third to get three in a row.
    	#This runs the win_block_move function defining a win.
        win_block_move(ttt_board, marker)

	end

	def block(ttt_board)
		#Block: If the opponent has two in a row, 
    	#the player must play the third themselves to block the opponent.
    	#This runs the win_block_move function defining a block.
        win_block_move(ttt_board, opponent)

	end

	def check_for_fork(ttt_board)
		#Fork: Create an opportunity where the player has two threats to win 
     	#(two non-blocked lines of 2).
     	#Blocking an opponent's fork: 
     	#Option 1: The player should create two in a row to force the opponent into defending, 
     	#as long as it doesn't result in them creating a fork. 
     	#For example, if "X" has two opposite corners and "O" has the center, 
     	#{}"O" must not play a corner in order to win. 
     	#(Playing a corner in this scenario creates a fork for "X" to win.)
     	#Option 2: If there is a configuration where the opponent can fork, 
     	#the player should block that fork.
		intersections = take_block_fork(ttt_board, @marker)

		if intersections.detect { |match| intersections.count(match) > 1 } == nil

			move = 10
		#Will not run unless under 8 index position
		else
				
			move = intersections.detect { |match| intersections.count(match) > 1 }
		
		end
				
		move
		
	end

	def block_fork(ttt_board)

		intersections = take_block_fork(ttt_board, @opponent)

		# Takes position 3 if the opponent sets up double corner fork on either side
		# This assumes the center tile takes priority after block fork 

		if ttt_board == [1, 2, opponent, 4, marker, 6, opponent, 8, 9]

			move = 3

		elsif ttt_board == [opponent, 2, 3, 4, marker, 6, 7, 8, opponent]

			move = 3

		elsif intersections.detect { |match| intersections.count(match) > 1 } == nil

			move = 10
		
		else
				
			move = intersections.detect { |match| intersections.count(match) > 1 }
		
		end
				
		move

	end

	def take_center(ttt_board)
		#Center: A player marks the center. 
    	#(If it is the first move of the game, playing on a corner gives the second player more 
    	#opportunities to make a mistake and may therefore be the better choice; 
    	#however, it makes no difference between perfect players.)
		if ttt_board[4].is_a?(Integer)
			move = 4
		else
			move = 10
		end
	end

	def opposite_corner(ttt_board)

		corner_combos = [[0,8],[2,6]]

		board_corners = [[ttt_board[0],ttt_board[8]],
						[ttt_board[2],ttt_board[6]]]
		corner_set = []
		move = 10

		board_corners.each_with_index do |value, pos|
			if value.count(opponent) == 1 && value.count { |x| x.is_a?(Integer) } == 1
				results = value.index { |x| x.is_a?(Integer) }
				move = corner_combos[pos][results]
			end
			
		end

		move

	end

	def empty_corner(ttt_board)

		corners = [0,2,6,8]
		empty = []

		corners.each do |pos|
			if ttt_board[pos].is_a?(Integer)
				empty << pos
			end
		end

		if empty.length > 0
			move = empty.shift
		else
			move = 10
		end
		move

	end

	def empty_side(ttt_board)

		sides = [1,3,5,7]
		empty = []

		sides.each do |pos|
			if ttt_board[pos].is_a?(Integer)
				empty << pos
			end
		end

		if empty.length > 0
			move = empty.shift
		else
			move = 10
		end
		move

	end

	def get_opponent(marker)
		opponent = 'X'

		if marker == 'X'
			opponent = 'O'
		else
			opponent = 'X'
		end
	end

	def win_block_move(ttt_board, player)

		win_combos = [
			[ttt_board[0], ttt_board[1], ttt_board[2]],
			[ttt_board[3], ttt_board[4], ttt_board[5]],
			[ttt_board[6], ttt_board[7], ttt_board[8]],
			[ttt_board[0], ttt_board[3], ttt_board[6]],
			[ttt_board[1], ttt_board[4], ttt_board[7]],
			[ttt_board[2], ttt_board[5], ttt_board[8]],
			[ttt_board[0], ttt_board[4], ttt_board[8]],
			[ttt_board[2], ttt_board[4], ttt_board[6]]
			
		]

		winners = [
			[0, 1, 2],
			[3, 4, 5],
			[6, 7, 8],
			[0, 3, 6],
			[1, 4, 7],
			[2, 5, 8],
			[0, 4, 8],
			[2, 4, 6]
		]

		move = 10

		win_combos.each_with_index do |val, pos|

			if
				val.count(player) == 2 && val.count { |x| x.is_a?(Integer) } == 1
				results = val.index { |x| x.is_a?(Integer) }
				move = winners[pos][results]
			else
				move
			end
		end
		move

	end

	def take_block_fork(ttt_board, player)
		#Fork: Create an opportunity where the player has two threats to win 
     	#(two non-blocked lines of 2).
     	#Blocking an opponent's fork: 
     	#Option 1: The player should create two in a row to force the opponent into defending, 
     	#as long as it doesn't result in them creating a fork. 
     	#For example, if "X" has two opposite corners and "O" has the center, 
     	#{}"O" must not play a corner in order to win. 
     	#(Playing a corner in this scenario creates a fork for "X" to win.)
     	#Option 2: If there is a configuration where the opponent can fork, 
     	#the player should block that fork.
		fork_combinations = [
							[ttt_board[0],ttt_board[1],ttt_board[2]],
							[ttt_board[3],ttt_board[4],ttt_board[5]],
							[ttt_board[6], ttt_board[7], ttt_board[8]],
							[ttt_board[0], ttt_board[3], ttt_board[6]],
							[ttt_board[1],ttt_board[4], ttt_board[7]],
							[ttt_board[2],ttt_board[5],ttt_board[8]], 
							[ttt_board[0], ttt_board[4], ttt_board[8]],
							[ttt_board[2],ttt_board[4],ttt_board[6]]
							]

		fork_positions = [[0,1,2],[3,4,5],[6,7,8],[0,3,6],[4,1,7],[2,5,8],[0,4,8],[2,4,6]]

		fork_spot = []
		i = []
		
		fork_combinations.each_with_index do |forking_line, index|
			if forking_line.count(player) == 1 && forking_line.count { |x| x.is_a?(Integer) } == 2
				i.push(index)
			end
		end

		i.each do |index|
			fork_spot << fork_positions[index]
		end
		
		fork_spot = fork_spot.flatten.sort

		intersections = []
		fork_spot.each do |spot|
			if ttt_board[spot].is_a?(Integer)
				intersections.push(spot)
			end
		end

		intersections
	end

end