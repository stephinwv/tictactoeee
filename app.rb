require "sinatra"
require_relative 'board_app.rb'
require_relative 'unbeatable_app.rb'
require_relative 'classes_app.rb'

enable :sessions




	get '/' do
	
		session[:board] = Board.new
		erb :welcome, :locals => {board: session[:board]}

	end

	post '/select_players' do
		session[:player1_type] = params[:player1]
		session[:player2_type] = params[:player2]
		session[:human1] = 'no'
		session[:human2] = 'no'

		if session[:player1_type] == 'Human'
			session[:player1] = Human.new('X')
			session[:human1] = 'yes'

		elsif session[:player1_type] == 'Easy'
			session[:player1] = Sequential.new('X')

		elsif session[:player1_type] == 'Medium'
			session[:player1] = RandomAI.new('X')

		elsif session[:player1_type] == 'Impossible!'
			session[:player1] = UnbeatableAI.new('X')
	
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

		if session[:human1] == 'yes'
			redirect '/board'
		else
			redirect '/make_move'
		end
	end

	
