# File that will launch the game, and combine all the classes/functions.

require_relative 'console_game.rb'

game = ConsoleGame.new

game.intro
game.display_board
until game.check_winner || game.board.full_board?
    
    game.update_board
    if game.check_winner == false
    	game.change_player
        game.display_board
    end
end    
    if
        game.check_winner == true
        game.display_board
		puts "#{game.active_player.marker} wins!"
		else
			game.check_winner == false
			game.display_board
			puts "It's a cat's game!"
		
	end
