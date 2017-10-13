require "sinatra"
require_relative 'board_app.rb'
require_relative 'unbeatable_app.rb'
require_relative 'classes_app.rb'
#These aren't actually app.rb's, they are files to be used for the web app
#that I have taken out the console human aspects. I left the original files intact
#for future reference and possible teaching tools.
enable :sessions

	get '/' do
	
		session[:board] = Board.new
		#Creating a new instance of the class Board
		erb :welcome, :locals => {board: session[:board]}

	end

	post '/select_players' do
		session[:player1_type] = params[:player1]
		session[:player2_type] = params[:player2]
		session[:human1] = 'no'
		session[:human2] = 'no'
		#Starting at no until Human is selected and then becomes yes.
		if session[:player1_type] == 'Human'
			session[:player1] = Human.new('X')
			#Creates a new instance of the Human class
			session[:human1] = 'yes'

		elsif session[:player1_type] == 'Easy'
			session[:player1] = Sequential.new('X')
			#Creates a new instance of the Sequential class
		elsif session[:player1_type] == 'Medium'
			session[:player1] = RandomAI.new('X')
			#Creates a new instance of the RandomAI class
		elsif session[:player1_type] == 'Impossible!'
			session[:player1] = UnbeatableAI.new('X')
			#Creates a new instance of the UnbeatableAI class
		end

		if session[:player2_type] == 'Human'
			session[:player2] = Human.new('O')
			session[:human2] = 'yes'

		elsif session[:player2_type] == 'Easy'
			session[:player2] = Sequential.new('O')

		elsif session[:player2_type] == 'Medium'
			session[:player2] = RandomAI.new('O')

		elsif session[:player2_type] == 'Impossible!'
			session[:player2] = UnbeatableAI.new('O')
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

		erb :main_board, :locals => {player1: session[:player1], player2: session[:player2], active_player: session[:active_player].marker, board: session[:board]}

	end

	get '/make_move' do
		# This will go through the functions designed to determine the next move and 
		#update the position for the AI as such
		move = session[:active_player].get_move(session[:board].ttt_board)
		session[:board].update_position(move, session[:active_player].marker)

		redirect '/check_game_state'

	end

	post '/human_move' do

		move = params[:choice].to_i - 1
		#Checks to see the if the position chosed by the human user is valid, if so then 
		#update said position.
		if session[:board].valid_position?(move)
			session[:board].update_position(move, session[:active_player].marker)
			redirect '/check_game_state'
		else
		 	redirect '/board'
		end

	end

	
