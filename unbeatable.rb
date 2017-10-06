
class Unbeatable
    attr_accessor :marker, :opponent
    def initialize(marker)
        @marker = marker
        @opponent = get_opponent(@marker)
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
    	#Possible moves are the individual index positions indicating where a move could be made.
        possible_moves =  [
            [ttt_board[0],ttt_board[1],ttt_board[2]],
            [ttt_board[3],ttt_board[4],ttt_board[5]],
            [ttt_board[6],ttt_board[7],ttt_board[8]],
            [ttt_board[0],ttt_board[3],ttt_board[6]],
            [ttt_board[1],ttt_board[4],ttt_board[7]],
            [ttt_board[2],ttt_board[5],ttt_board[8]],
            [ttt_board[0],ttt_board[4],ttt_board[8]],
            [ttt_board[2],ttt_board[4],ttt_board[6]],
            ]
        #Possible Combos are the arrays of index positions of winning combinations.
        possible_combos = [
            [0, 1, 2],
            [3, 4, 5],
            [6, 7, 8],
            [0, 3, 6],
            [1, 4, 7],
            [2, 5, 8],
            [0, 4, 8],
            [2, 4, 6]
        ]
     
        move = 56
        #move is set at 56 initially in part to set value at start to be changed by results
    	#from the following functions. If in the console move returns 50 we know something is very wrong.
       
        possible_moves.each_with_index do |winning_line, index_of_array|
       #Takes each line or array of winning combo and the index position of that array
            if winning_line.count(player) == 2 && winning_line.count('') == 1
            	#If the player has 2 positions taken in that array and one space is an empty string,
            	#then the index position of the empty space in that array is assigned to "move" 
                p index_of_array
                winner = winning_line.index('')
                move = possible_combos[index_of_array][winner]
            else 
                move
            end
            
       end
        move
    end
    def get_move(ttt_board)
    	#move is set at 50 initially in part to set value at start to be changed by results
    	#from the following functions. If in the console move returns 50 we know something is very wrong.
    	# This is the order of which functions are called in order to establish where the computer should 
    	#place the next move.
        move = 50
            if  win(ttt_board) <= 8
                 move = win(ttt_board) 

            elsif  block(ttt_board) <= 8
                move = block(ttt_board) 
            elsif take_center(ttt_board) <= 8
                move = take_center(ttt_board)  
            elsif take_corner(ttt_board) <= 8
                move = take_corner(ttt_board)
            
            else
                move = ttt_board.index("") 
            
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
    def take_center(ttt_board)
    	#Center: A player marks the center. 
    	#(If it is the first move of the game, playing on a corner gives the second player more 
    	#opportunities to make a mistake and may therefore be the better choice; 
    	#however, it makes no difference between perfect players.)
        if ttt_board[4] == ''
            move = 4
        else
            move = 56
        end
    end
    def take_corner(ttt_board)
    	#Opposite corner: If the opponent is in the corner, the player plays the opposite corner.
    	#Empty corner: The player plays in a corner square.
        if ttt_board[0] == ''
            move = 0
        elsif ttt_board[2] == ''
            move = 2
        elsif ttt_board[6] == ''
            move = 6
        elsif ttt_board[8] == ''
            move = 8
        else 
            move = 56
        end
    end
     def get_fork(ttt_board)
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
        if 
            ttt_board[0] == ''
            move = 0

        elsif 
            ttt_board[2] == ''
            move = 2

        elsif 
            ttt_board[6] == ''
            move = 6
        
        elsif 
            ttt_board[8] == ''
            move = 8

        else 
            move = 60
        end
    end
end