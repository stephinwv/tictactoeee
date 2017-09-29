require "sinatra"
class Board
	class Board
	attr_accessor :board,

def initialize()
	@board=Array.new(9, "")
end
def display
		board = ['1', '2', '3', '4', '5', '6', '7', '8', '9']
	    p " #{board[0]} | #{board[1]} | #{board[2]} "
	    p "---|---|---"
	    p " #{board[3]} | #{board[4]} | #{board[5]} "
	    p "---|---|---"
	    p " #{board[6]} | #{board[7]} | #{board[8]} "

end									

def update_move(player, position)

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

def change_player(player)
	
	if player == 'x'
			player = 'o'
	elsif player == 'o'
			player = "x"
	end
	player

end
def full(board)
	if @board.all? {|space| space.include?('o') || space.include?('x')}
		full = true	
	else
		full = false
	end
	puts "full is #{full}"
	full
end
def winner?(board)

    #p "board is #{board}"
    #    if  board[0] == "x" && board[3] == "x" && board[6] == "x" || board[0] == "o" && board[3] == "o" && board[6] == "o"
    #     true
    #    elsif board[1] == "x" && board[4] == "x" && board[7] == "x" || board[1] == "o" && board[4] == "o" && board[7] == "o"
    #     true
    #    elsif board[2] == "x" && board[5] == "x" && board[8] == "x" || board[2] == "o" && board[5] == "o" && board[8] == "o"
    #     true
    #    elsif board[0] == "x" && board[1] == "x" && board[2] == "x" || board[0] == "o" && board[1] == "o" && board[2] == "o"
    #     true
    #    elsif board[3] == "x" && board[4] == "x" && board[5] == "x" || board[3] == "o" && board[4] == "o" && board[5] == "o"
    #     true
    #    elsif board[6] == "x" && board[7] == "x" && board[8] == "x" || board[6] == "o" && board[7] == "o" && board[8] == "o"
    #     true
    #    elsif board[0] == "x" && board[4] == "x" && board[8] == "x" || board[0] == "o" && board[4] == "o" && board[8] == "o"
    #     true
    #    elsif board[2] == "x" && board[4] == "x" && board[6] == "x" || board[2] == "o" && board[4] == "o" && board[6] == "o"
    #     true
    #    else 
    #     false
    # end
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
def display
		@board = ['1', '2', '3', '4', '5', '6', '7', '8', '9']
	    p " #{board[0]} | #{board[1]} | #{board[2]} "
	    p "---|---|---"
	    p " #{board[3]} | #{board[4]} | #{board[5]} "
	    p "---|---|---"
	    p " #{board[6]} | #{board[7]} | #{board[8]} "

end									


