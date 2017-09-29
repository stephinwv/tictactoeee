class Board
	attr_accessor :board

	def initialize()
		@board=Array.new(9, "")
	end
	
	def update_move(position, player)

	@board[position.to_i-1] = player

	end
	def spot_open?(position)
		if @board[position-1] == 'x' || @board[position-1] == 'o'
			false
			elsif position>=10 || position<=0
			false
		else
			true
		end
	end
	def full(board)
	board.count("") == 0
	end
	puts "full is #{full}"
	full
	end

	def winner?(board)
    wincombs = [ [0,1,2], [0,3,6], [1,4,7], [3,4,5],[6,7,8], [2,5,8], [0,4,8], [2,4,6] ]
		wincombs.each do |inner_array|
		count = 0
			inner_array.each do |value|
				if board[value]==player
				count += 1
					if count == 3
					results = true
					end
				end
			end
		end   						
	end
	results						
end					
