# File that will launch the game, and combine all the classes/functions.

require_relative 'console_game.rb'

game = ConsoleGame.new

game.intro

until game.check_winner || game.board.full_board?

	
# game.get_move
game.update_board
game.change_player
game.display_board
end

if game.check_winner
	puts "#{game.active_player.marker} wins!"
else
	puts "It's a cat's game!"
end