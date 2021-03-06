require 'rubygems'
require 'sinatra'

require 'pg'

require_relative 'board_app.rb'
require_relative 'unbeatable_app.rb'
require_relative 'classes_app.rb'
#These aren't actually app.rb's, they are files to be used for the web app
#that I have taken out the console human aspects. I left the original files intact
#for future reference and possible teaching tools.
enable :sessions
load './local_env.rb' if File.exists?('./local_env.rb')


db_params = {
	host: ENV['host'],
	port: ENV['port'],
	dbname: ENV['dbname'],
	user: ENV['user'],
	password: ENV['password']
}

db = PG::Connection.new(db_params)

	get '/' do
	
		session[:board] = Board.new
		#Creating a new instance of the class Board
		tictactoe = db.exec("Select * From tictactoe");
		
		erb :welcome, :locals => {board: session[:board]}

	end

	post '/select_players' do
		
		session[:player1_type] = params[:player1]
		session[:player2_type] = params[:player2]
		session[:human1] = 'no'
		session[:human2] = 'no'
		session[:pname1] = params[:pname1]
		session[:pname2] = params[:pname2]
		#Starting at no until Human is selected and then becomes yes.
		if session[:player1_type] == 'Human'
			session[:player1] = Human.new('X')
			#Creates a new instance of the Human class
			session[:human1] = 'yes'

		elsif session[:player1_type] == 'Easy'
			session[:player1] = Sequential.new('X')
			session[:pname1] = 'Easy AI'
			#Creates a new instance of the Sequential class
		elsif session[:player1_type] == 'Medium'
			session[:player1] = RandomAI.new('X')
			#Creates a new instance of the RandomAI class
			session[:pname1] = 'Medium AI'
		elsif session[:player1_type] == 'Impossible!'
			session[:player1] = UnbeatableAI.new('X')
			#Creates a new instance of the UnbeatableAI class
			session[:pname1] = 'Impossible AI'
		end

		if session[:player2_type] == 'Human'
			session[:player2] = Human.new('O')
			session[:human2] = 'yes'

		elsif session[:player2_type] == 'Easy'
			session[:player2] = Sequential.new('O')
			session[:pname2] = 'Easy AI'

		elsif session[:player2_type] == 'Medium'
			session[:player2] = RandomAI.new('O')
			session[:pname2] = 'Medium AI'

		elsif session[:player2_type] == 'Impossible!'
			session[:player2] = UnbeatableAI.new('O')
			session[:pname2] = 'Impossible AI'
		# else
		# 	redirect '/'
		end

		session[:active_player] = session[:player1] 
		#determines which player is the current or active player, 
		#if human, go to board, if AI go to make_move
		if session[:human1] == 'yes'
			redirect '/board'
		else
			redirect '/make_move'
		end
	end

	get '/board' do

		erb :main_board, :locals => {pname1: session[:pname1], pname2: session[:pname2], player1: session[:player1], player2: session[:player2], active_player: session[:active_player].marker, board: session[:board]}

	end

	get '/make_move' do

		# This will go through the functions passing in the variables, designed to determine the next move and 
		#update the position for the AI as such
		move = session[:active_player].get_move(session[:board].ttt_board)
		session[:board].update_position(move, session[:active_player].marker)
		
		redirect '/check_game_state'

	end

	post '/human_move' do

		move = params[:choice].to_i - 1
		#Checks to see the if the position chosen by the human user is valid, if so then 
		#update said position.
		if session[:board].valid_position?(move)
			puts move
			session[:board].update_position(move, session[:active_player].marker)
			redirect '/check_game_state'
		else
			puts move
		 	redirect '/board'
		end

	end

	get '/check_game_state' do
	
		#Checks the status of the board, and gives a message of the results,
		#whether there is a winner or a tie. If none of these scenerios are found then 
		#another move will be made, until one is met
		if session[:board].winner?(session[:active_player].marker)

			message = "#{session[:active_player].marker} Won!"

			player1 = session[:player1]
			player2 = session[:player2]
			winner = session[:active_player].marker
			db.exec("INSERT INTO tictactoe(x, o, result, time) VALUES('#{session[:pname1]}', '#{session[:pname2]}',  '#{message}', '#{Time.now}')")
			erb :game_over, :locals => {board: session[:board], message: message}
		
		elsif session[:board].full_board?

			message = 'Kitty Kitty!'

			db.exec("INSERT INTO tictactoe(x, o, result, time) VALUES('#{session[:pname1]}', '#{session[:pname2]}',  '#{message}', '#{Time.now}')")
			erb :game_over, :locals => {board: session[:board], message: message}

		else
			if session[:active_player] == session[:player1]
				session[:active_player] = session[:player2]
			else
				session[:active_player] = session[:player1]
			end

			if session[:active_player] == session[:player1] && session[:human1] == 'yes' || session[:active_player] == session[:player2] && session[:human2] == 'yes'
				redirect '/board'
			else
				redirect '/make_move'
			end

		end

		

	end	
	get '/clear_sessions' do
		#A link appears under the game over display of the board to play again. This link
		#erases and resets all the sessions, and takes you to the welcome page to try again.
		session[:board] = nil
		session[:active_player] = nil
		session[:human1] = nil
		session[:human2] = nil
		session[:player1_type] = nil
		session[:player2_type] = nil

		redirect '/'

	end
	get '/game_results' do
		tictactoe = db.exec("Select * From tictactoe");
		erb :game_results, locals: {tictactoe: tictactoe}

	end
	