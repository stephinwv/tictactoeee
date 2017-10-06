
class Board

	attr_accessor :ttt_board

	def initialize
		@ttt_board = Array.new(9, " ")
	end

	def update_position(position, marker)
		ttt_board[position] = marker
	end

	def valid_position?(position)

		if ttt_board[position] == " "
			#IF THERE IS AN EMPTY STRING, IT IS A VALID SPACE
			true
		else
			false
		end
		
	end

	def valid_input?(input)
		
		if input.match(/[xXoO]/)
			true
		else
			false
		end
		
	end

	def full_board?
		if ttt_board.include?(' ')
			false
		else
			true
		end
	end

	def winner?(marker)

		#2D array of winning combos
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

		#Set results to false by default.
		results = false

		#Nested loops.  Iterates over 'outer' array
		#Then iterates over each inner_array.
		#Uses the value from each number in the inner array as
		#an index position in ttt_board.
		#If there is a match, it adds to count. If count reaches
		#three, results get set to true because all 3 in a set matched.
		#Count is reset to 0 for every new inner array item
		#because it is outside the inner loop.
		winners.each do |winner|
			count = 0

			winner.each do |value|

				if ttt_board[value] == marker

					count += 1

					if count == 3

						results = true

					end
				end
			end
		end
		#Calls our results which is false by default.
		#Only true if a set of the three combos matches.
		results

	end


end
#THIS IS THE CODE I STARTED WITH AND WE WENT ANOTHER DIRECTION TOGETHER IN CLASS
# class Board
# 	attr_accessor :board

# 	def initialize()
# 		@tttboard=Array.new(9, "")
# 	end
	
# 	def update_move(position, player)

# 		@tttboard[position.to_i-1] = player

# 	end
# 	def spot_open?(position)
# 		if @tttboard[position-1] == 'x' || @tttboard[position-1] == 'o'
# 			false
# 			elsif position>=10 || position<=0
# 			false
# 		else
# 			true
# 		end
# 	end
# 	def full(board)
# 	board.count("") == 0
# 	end
# 	puts "full is #{full}"
# 	full
# 	end

# 	def winner?(board)
#     wincombs = [ [0,1,2], [0,3,6], [1,4,7], [3,4,5],[6,7,8], [2,5,8], [0,4,8], [2,4,6] ]
# 		wincombs.each do |inner_array|
# 		count = 0
# 			inner_array.each do |value|
# 				if board[value]==player
# 				count += 1
# 					if count == 3
# 					results = true
# 					end
# 				end
# 			end
# 		end   						

# 	results						
# end					