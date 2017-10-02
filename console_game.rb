require_relative 'board.rb'
require_relative 'console_human.rb'
# require_relative 'unbeatable.rb'


class ConsoleGame

	attr_accessor :player_1, :player_2, :board, :active_player, :move, :input1, :input2

	def initialize
		@player_1 = get_player1
		@player_2 = get_player2
		@board = Board.new	
		@active_player = player_1
	end

	def intro
		puts 'Welcome to tic-tac-toe'
		puts "It's #{@active_player.marker}'s turn"
		
	end

	def display_board
 		
	  	puts " #{board.ttt_board[0]} | #{board.ttt_board[1]} | #{board.ttt_board[2]} "
	 	 puts "-----------"
	 	 puts " #{board.ttt_board[3]} | #{board.ttt_board[4]} | #{board.ttt_board[5]} "
	 	 puts "-----------"
	 	 puts " #{board.ttt_board[6]} | #{board.ttt_board[7]} | #{board.ttt_board[8]} "
	 	 puts "             "
		
		
	  if check_winner || board.full_board?
	  	puts "Game Over"
	  else
	  puts "It's #{@active_player.marker}'s turn"
	  end
	
	end

	def get_move
		active_player.get_move(board.ttt_board)	
	end

	def update_board
		marker = active_player.marker
		move = get_move
		

		if board.valid_position?(move)
			board.update_position(move, marker)
		else
			puts "Invalid move, please choose again"
			update_board
		end
	end

	def change_player
		
		if @active_player == player_1
			@active_player = player_2
		else
			@active_player = player_1
		end	
	end

	def check_winner
		if board.winner?(active_player.marker)
			true
		else
			false
		end	
	end

	def get_player1
		puts """
			Please select player 1 by entering a number below
			1 - Human
			2 - Easy Computer
			3 - Medium Computer
			4 - Impossible Computer
			"""
		@input1 = gets.chomp.to_i

		if input1 == 1
			@player_1 = Human.new('O')

		elsif input1 == 2
			@player_1 = Sequential.new('O')

		elsif input1 == 3
			@player_1 = RandomAI.new('O')

		elsif input1 == 4
			@player_1 = UnbeatableAI.new('O')

		else
			puts "Invalid input, please input 1, 2, 3, or 4"
			get_player1
		end

	end

	def get_player2
		puts """
			Please select player 2 by entering a number below
			1 - Human
			2 - Easy Computer
			3 - Medium Computer
			4 - Impossible Computer
			"""
		@input2 = gets.chomp.to_i

		if input2 == 1
			@player_2 = Human.new('X')

		elsif input2 == 2
			@player_2 = Sequential.new('X')

		elsif input2 == 3
			@player_2 = RandomAI.new('X')

		elsif input2 == 4
			@player_2 = UnbeatableAI.new('X')
		else
			puts "Invalid input, please input 1, 2, 3, or 4."
			get_player2
		end
	end

end
